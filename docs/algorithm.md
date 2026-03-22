# ゲーム推薦アルゴリズム ドキュメント

## カラムと質問の対応表

| 質問番号 | DB カラム        | A 選択の意味                      | B 選択の意味                    | invert |
|---------|-----------------|----------------------------------|-------------------------------|--------|
| Q1      | is_retro        | レトロな名作を遊びたい (true)       | モダンな新作を遊びたい (false)   | true   |
| Q2      | is_party        | みんなでわいわい (true)            | ひとりでとことん (false)         | true   |
| Q3      | is_action       | 直感で進めるアクション！ (true)     | のんびりほのぼの (false)         | true   |
| Q4      | is_long_play    | 腰を据えて長めに (true)            | サクッと気軽に (false)           | true   |
| Q5      | is_hard         | 歯ごたえがあるほど燃える！ (true)   | 気軽に楽しみたい (false)         | true   |
| Q6      | is_strategic    | 爽快感あふれるゲームが好き (false)  | じっくり戦略を考える (true)      | false  |
| Q7      | is_story_driven | 物語や世界観を楽しみたい (true)     | とにかく動きたい！ (false)        | true   |
| Q8      | is_educational  | 勉強がしたい (true)               | 日常から離れたい！ (false)        | true   |
| Q9      | is_sports       | スポーツ系が好き (true)            | 別の遊びがしたい (false)          | true   |
| Q10     | is_collectible  | コレクション要素が好き (true)       | 探索・冒険が好き (false)          | true   |

**invert の意味:**
- `invert=true` : フロントから `0`（A 選択）が送られたとき → DB では `true` を検索
- `invert=false`: フロントから `0`（A 選択）が送られたとき → DB では `false` を検索

---

## 実装: 決定木アルゴリズム (`/api/next-question`)

### 関連ファイル

- `backend/decision_tree.go` — アルゴリズム本体
- `backend/handler.go` — 構造体定義・エンドポイント
- `frontend/quiz.html` — クイズ UI

### フロー概要

```
POST /api/next-question  { "a1": 0, "a3": 1, ... }
```

```
┌─────────────────────────────────────────────────────────┐
│ 回答済みの質問からWHERE句を生成し残りゲーム数を取得          │
└────────────────────────┬────────────────────────────────┘
                         │
              ┌──────────▼──────────┐
              │  残り1件以下         │  YES → ゲーム一覧を返す（done: true）
              │  または全10問回答済み？│
              └──────────┬──────────┘
                         │ NO
              ┌──────────▼──────────┐
              │  Q1・Q2は固定順で     │
              │  未回答ならそちらを返す │
              └──────────┬──────────┘
                         │ Q1,Q2 回答済みの場合
              ┌──────────▼──────────────────────────────────┐
              │  未回答カラムごとに                           │
              │  score = min(trueCount, falseCount) を計算   │
              │  最高スコアの質問を次の質問として返す           │
              └──────────┬──────────────────────────────────┘
                         │
              ┌──────────▼──────────┐
              │  有効な分割なし？      │  YES → 現時点の結果を返す（done: true）
              └─────────────────────┘
```

### アルゴリズム詳細

1. **WHERE 句の構築** (`buildWhere`)
   - 送信された回答 `{ "a1": 0, "a3": 1, ... }` から `colMap` を参照して SQL 条件を生成
   - `invert=true` のカラムは `a=0` → `col=true`、`a=1` → `col=false`

2. **終了条件の判定**
   - `remaining <= 1`（残りゲームが 1 件以下）
   - `len(answered) >= 10`（全 10 問回答済み）
   - いずれかを満たしたとき `sendGames` を呼び出してゲームを返す

3. **固定先行質問（Q1・Q2）**
   - 最初の 2 問は必ず Q1（レトロ/モダン）→ Q2（パーティ/ひとり）の順で出題
   - ゲーム群の大分類を先に絞り込むことで後続の分割効率を上げるため

4. **動的質問選択（Q3 以降）**
   - 未回答の各カラムについて `COUNT(*) WHERE <現在条件> AND col=true` を取得
   - `falseCount = remaining - trueCount`
   - `score = min(trueCount, falseCount)` — 50:50 に近いほど高スコア
   - 最高スコアのカラムを次の質問として選択

5. **有効分割なし**
   - 全未回答カラムの `score = 0` の場合（残りゲームが片方の答えに偏り切っている）
   - 即時 `sendGames` を呼び出す

### DB クエリ数

1 回の `/api/next-question` で実行されるクエリ数:
- 残りゲーム数 COUNT: **1 回**
- 動的質問選択時の候補スキャン: **最大 8 回**（未回答カラム数）
- ゲーム取得 + 類似タイトル取得: **2 回**

---

## レスポンス形式

### 次の質問を返す場合

```json
{
  "done": false,
  "question": {
    "number": 3,
    "text": "どんなゲームがお好みですか？",
    "choiceA": "直感で進めるアクション！",
    "choiceB": "のんびりほのぼの"
  },
  "remaining": 143
}
```

### 終了時（ゲームを返す場合）

```json
{
  "done": true,
  "total": 3,
  "games": [
    {
      "id": 1,
      "title": "スーパーマリオ オデッセイ",
      "official_url": "https://www.nintendo.com/jp/switch/aaaca/index.html",
      "similar_items": [
        {
          "title": "スーパーマリオ 3Dワールド + フューリーワールド",
          "official_url": "https://www.nintendo.com/jp/switch/auzpa/index.html"
        }
      ]
    }
  ]
}
```

---

## フロントエンド状態管理 (sessionStorage)

| キー            | 内容                                      | 保存タイミング         |
|----------------|------------------------------------------|----------------------|
| `quiz_state`   | `{ history: [...], answers: {...} }`     | 結果画面へ遷移する直前  |
| `result`       | `[{ id, title, official_url, ... }, ...]`| 結果画面へ遷移する直前  |
| `result_total` | 該当件数（数値）                           | 結果画面へ遷移する直前  |

`quiz_state` の `history` は `[{ question: {...}, answer: 0|1 }, ...]` の配列。
結果画面から「前の質問に戻る」を押した際にこれを復元し、最後の質問を再表示する。
