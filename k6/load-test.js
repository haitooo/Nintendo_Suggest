import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { Rate, Trend, Counter } from 'k6/metrics';

// ---- カスタムメトリクス ----
const errorRate       = new Rate('error_rate');
const quizCompleted   = new Counter('quiz_completed');
const quizAbandoned   = new Counter('quiz_abandoned');
const apiLatency      = new Trend('api_latency_ms', true);

// ---- テスト設定 ----
// CPU: 8コア × 90% = 7200m を使い切る負荷を想定
// VU 200 がピーク（1VU ≈ 1同時ユーザー）
export const options = {
  stages: [
    { duration: '30s', target: 200  },  // ウォームアップ
    { duration: '30s', target: 500  },  // 増加
    { duration: '30s', target: 1000 },  // さらに増加
    { duration: '30s', target: 2000 },  // 高負荷
    { duration: '60s', target: 2000 },  // ピーク維持
    { duration: '30s', target: 0    },  // ランプダウン
  ],
  thresholds: {
    http_req_duration:    ['p(95)<800', 'p(99)<1500'],
    http_req_failed:      ['rate<0.02'],
    error_rate:           ['rate<0.02'],
    api_latency_ms:       ['p(95)<600'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080';

const PAGES = {
  top:    `${BASE_URL}/`,
  quiz:   `${BASE_URL}/quiz.html`,
  result: `${BASE_URL}/result.html`,
};

const API = {
  questions:    `${BASE_URL}/api/questions`,
  nextQuestion: `${BASE_URL}/api/next-question`,
};

const JSON_HEADERS = { headers: { 'Content-Type': 'application/json' } };

// ---- ユーティリティ ----
function randomBetween(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// 思考時間（限界測定のため短縮）
function thinkTime() {
  sleep(Math.random() * 0.5 + 0.1);
}

// ---- シナリオ ----

/**
 * シナリオA: 普通のユーザー
 * トップ → クイズ → 全問回答 → 結果確認
 */
function normalUser() {
  group('トップページ訪問', () => {
    const res = http.get(PAGES.top);
    check(res, { 'top: 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });
  thinkTime();

  group('クイズページに移動', () => {
    const res = http.get(PAGES.quiz);
    check(res, { 'quiz: 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });
  thinkTime();

  // クイズを全問回答
  const answers = {};
  let done = false;

  for (let i = 0; i < 12; i++) {
    const start = Date.now();
    const res = http.post(API.nextQuestion, JSON.stringify(answers), JSON_HEADERS);
    apiLatency.add(Date.now() - start);

    const ok = check(res, {
      'next-question: 200': (r) => r.status === 200,
    });
    errorRate.add(!ok);
    if (!ok) { quizAbandoned.add(1); return; }

    let body;
    try { body = JSON.parse(res.body); } catch (_) { quizAbandoned.add(1); return; }

    if (body.done) {
      done = true;
      break;
    }

    if (body.question) {
      // ランダムに A (0) か B (1) を選択
      answers[`a${body.question.number}`] = Math.random() < 0.5 ? 0 : 1;
    }

    // 質問を読んで考える時間（限界測定のため短縮）
    sleep(Math.random() * 0.3 + 0.1);
  }

  if (done) {
    group('結果ページ閲覧', () => {
      const res = http.get(PAGES.result);
      check(res, { 'result: 200': (r) => r.status === 200 });
      errorRate.add(res.status !== 200);
    });
    quizCompleted.add(1);
    sleep(randomBetween(1, 2)); // 結果を眺める
  } else {
    quizAbandoned.add(1);
  }
}

/**
 * シナリオB: 離脱ユーザー
 * トップ → クイズ途中で離脱
 */
function bouncingUser() {
  group('トップページのみ閲覧', () => {
    const res = http.get(PAGES.top);
    check(res, { 'top: 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });
  sleep(Math.random() * 0.3 + 0.1);

  // 50% の確率でクイズページに進む
  if (Math.random() < 0.5) {
    http.get(PAGES.quiz);
    sleep(Math.random() * 0.2 + 0.1);

    // 1〜3問だけ回答して離脱
    const answers = {};
    const stopAt = randomBetween(1, 3);
    for (let i = 0; i < stopAt; i++) {
      const res = http.post(API.nextQuestion, JSON.stringify(answers), JSON_HEADERS);
      if (res.status !== 200) break;
      try {
        const body = JSON.parse(res.body);
        if (body.done || !body.question) break;
        answers[`a${body.question.number}`] = Math.random() < 0.5 ? 0 : 1;
      } catch (_) { break; }
      sleep(Math.random() * 0.2 + 0.1);
    }
    quizAbandoned.add(1);
  }
}

/**
 * シナリオC: リピーターユーザー
 * クイズを2〜3回繰り返す
 */
function repeatingUser() {
  const times = randomBetween(2, 3);
  for (let t = 0; t < times; t++) {
    group(`クイズ ${t + 1}回目`, () => {
      http.get(PAGES.top);
      thinkTime();
      http.get(PAGES.quiz);
      sleep(0.2);

      const answers = {};
      for (let i = 0; i < 12; i++) {
        const res = http.post(API.nextQuestion, JSON.stringify(answers), JSON_HEADERS);
        if (res.status !== 200) break;
        let body;
        try { body = JSON.parse(res.body); } catch (_) { break; }
        if (body.done) { quizCompleted.add(1); break; }
        if (body.question) {
          answers[`a${body.question.number}`] = Math.random() < 0.5 ? 0 : 1;
        }
        sleep(Math.random() * 0.3 + 0.1);
      }
    });
    sleep(Math.random() * 0.5 + 0.2); // 次のプレイまでの間
  }
}

// ---- メイン ----
export default function () {
  // ユーザータイプをランダムに振り分け
  const roll = Math.random();
  if (roll < 0.60) {
    normalUser();      // 60%: 普通にクイズを完走
  } else if (roll < 0.85) {
    bouncingUser();    // 25%: 途中離脱
  } else {
    repeatingUser();   // 15%: 複数回プレイ
  }
}
