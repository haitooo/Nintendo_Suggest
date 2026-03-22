# 任天堂ソフト診断 — アプリ概要

## アプリについて

「任天堂ソフト診断」は、いくつかの質問に答えるだけで自分に合った任天堂ゲームソフトをおすすめしてくれる Web アプリです。

決定木アルゴリズムを用いて毎回最適な質問を動的に選択し、最小限の問数でユーザーの好みに合ったタイトルを提案します。Nintendo Switch / Switch 2 の現行タイトルから、Nintendo Switch Online のクラシックゲームまで 170 タイトル以上に対応しています。

---

## 技術スタック

### バックエンド

| 技術 | バージョン | 用途 |
|------|----------|------|
| Go | 1.23.12 | API サーバー |
| `net/http` | 標準ライブラリ | HTTP ルーティング |
| `go-sql-driver/mysql` | v1.7.1 | MySQL ドライバ |

フレームワークを使わず標準ライブラリのみで構成しています。

### フロントエンド

| 技術 | 用途 |
|------|------|
| HTML5 / CSS3 | マークアップ・スタイリング |
| Vanilla JavaScript | クイズ進行・状態管理・結果表示 |
| sessionStorage | ページ間の状態保持 |

npm パッケージ不使用。ビルドステップなしの純粋な静的ファイルです。

### データベース

| 技術 | バージョン | 用途 |
|------|----------|------|
| MySQL | 8.0 | ゲームデータ・類似タイトルの管理 |

文字コードは `utf8mb4`（絵文字・日本語に対応）。

### インフラ

| 技術 | 用途 |
|------|------|
| Docker / Docker Compose | コンテナオーケストレーション |
| Nginx (alpine) | 静的ファイル配信 / リバースプロキシ |

---

## アーキテクチャ

```
ブラウザ
  │
  │ HTTP :8080
  ▼
┌──────────┐
│  Nginx   │  静的ファイル (HTML/CSS/JS) を配信
│ frontend │  /api/* → backend へ転送
└────┬─────┘
     │ HTTP (app_net)
     ▼
┌──────────┐
│   Go     │  REST API サーバー
│ backend  │  決定木アルゴリズムで質問を動的選択
└────┬─────┘
     │ TCP 3306 (db_net)
     ▼
┌──────────┐
│  MySQL   │  ゲームデータ・類似タイトル
│    db    │
└──────────┘
```

- `frontend` と `backend` は `app_net` で接続
- `backend` と `db` は `db_net` で接続（DB は外部非公開）
- `db` の起動ヘルスチェックが通過してから `backend` が起動

---

## プロジェクト構成

```
nintendo_suggest/
├── backend/
│   ├── main.go             # エントリーポイント・DB接続・ルーティング
│   ├── handler.go          # 構造体定義・HTTPハンドラ
│   ├── decision_tree.go    # 決定木アルゴリズム実装
│   ├── questions.go        # 質問データ定義
│   ├── Dockerfile
│   ├── go.mod
│   └── go.sum
├── frontend/
│   ├── index.html          # トップページ
│   ├── quiz.html           # クイズ画面
│   ├── result.html         # 診断結果画面
│   ├── css/style.css       # 共通スタイル
│   ├── nginx.conf          # リバースプロキシ設定
│   └── Dockerfile
├── db/
│   ├── init.sql            # gamesテーブル・全タイトルデータ
│   ├── init_similarities.sql # game_similaritiesテーブル・類似タイトルデータ
│   └── Dockerfile
├── docs/
│   ├── overview.md         # 本ドキュメント
│   └── algorithm.md        # アルゴリズム詳細
├── docker-compose.yaml
├── Makefile
└── .env
```

---

## API エンドポイント

| メソッド | パス | 概要 |
|---------|-----|------|
| `POST` | `/api/next-question` | 決定木による次の質問または結果を返す |
| `GET`  | `/api/questions` | 全質問一覧を返す |
| `POST` | `/api/count` | 現在の回答条件に一致するゲーム数を返す（デバッグ用） |

リクエスト・レスポンスの詳細は [algorithm.md](./algorithm.md) を参照。

---

## 起動方法

```bash
# 初回 or 全クリーンビルド
make re

# 通常起動
make up

# ログ確認
make logs

# 停止
make down
```

ブラウザで `http://localhost:8080` にアクセスすると診断が開始できます。

---

## データについて

- **ゲームタイトル数**: 179 タイトル（`games` テーブル）
- **類似タイトル数**: 84 エントリ（`game_similarities` テーブル）
- **対応ハード**: Nintendo Switch / Switch 2、NSO（FC / SFC / N64 / GBA / GB・GBC / バーチャルボーイ / ゲームキューブ）
- 各タイトルには任天堂またはポケモン公式サイトへの `official_url` を付与
