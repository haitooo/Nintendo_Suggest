SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS game_similarities (
    id             INT PRIMARY KEY AUTO_INCREMENT,
    game_id        INT NOT NULL,
    similar_title  VARCHAR(255) NOT NULL,
    official_url   VARCHAR(512) DEFAULT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 類似タイトルの追加はここに (game_id, '類似タイトル', 'URL') を追記する
-- game_id は init.sql の各行先頭の数値を参照
INSERT INTO game_similarities (game_id, similar_title, official_url) VALUES

    -- ============================================================
    -- Nintendo Switch / Switch 2
    -- ============================================================

    ( 1, 'スーパーマリオ 3Dワールド + フューリーワールド', 'https://www.nintendo.com/jp/switch/auzpa/index.html'),   -- スーパーマリオ オデッセイ
    ( 1, 'スーパーマリオ ギャラクシー + スーパーマリオ ギャラクシー 2', 'https://www.nintendo.com/jp/switch/bpdpa/index.html'), -- スーパーマリオ オデッセイ

    ( 2, 'New スーパーマリオブラザーズ U デラックス', 'https://www.nintendo.com/jp/switch/adala/index.html'),          -- スーパーマリオブラザーズ ワンダー

    ( 5, 'マリオパーティ スーパースターズ', 'https://www.nintendo.com/jp/switch/az82a/index.html'),                    -- スーパー マリオパーティ ジャンボリー
    ( 5, 'スーパー マリオパーティ', 'https://www.nintendo.com/jp/switch/adfja/index.html'),                            -- スーパー マリオパーティ ジャンボリー

    ( 9, 'ペーパーマリオ オリガミキング', 'https://www.nintendo.com/jp/switch/aruua/index.html'),                      -- ペーパーマリオRPG

    (13, 'マリオカート8 デラックス', 'https://www.nintendo.com/jp/switch/aabpa/index.html'),                           -- マリオカート ワールド

    (14, 'マリオテニス エース', 'https://www.nintendo.com/jp/switch/alera/index.html'),                                -- マリオテニス フィーバー

    (15, 'ゼルダの伝説 ブレス オブ ザ ワイルド', 'https://www.nintendo.com/jp/zelda/botw/index.html'),               -- ゼルダの伝説 ティアーズ オブ ザ キングダム
    (15, 'ゼルダの伝説 スカイウォードソード HD', 'https://www.nintendo.com/jp/switch/az89a/index.html'),               -- ゼルダの伝説 ティアーズ オブ ザ キングダム

    (18, 'スプラトゥーン2', 'https://www.nintendo.com/jp/switch/aab6a/index.html'),                                    -- スプラトゥーン3

    (21, 'ルイージマンション３', 'https://www.nintendo.com/jp/switch/ag3ja/index.html'),                               -- ルイージマンション２ HD

    (22, '星のカービィ Wii デラックス', 'https://www.nintendo.com/jp/switch/a2jya/index.html'),                        -- 星のカービィ スターアライズ

    (29, 'ドンキーコング リターンズ HD', 'https://www.nintendo.com/jp/switch/bdlwa/index.html'),                       -- ドンキーコング トロピカルフリーズ

    (31, 'ピクミン３ デラックス', 'https://www.nintendo.com/jp/switch/ampna/index.html'),                              -- ピクミン４
    (31, 'ピクミン１+２', 'https://www.nintendo.com/jp/switch/bamea/index.html'),                                      -- ピクミン４

    (32, 'メトロイド ドレッド', 'https://www.nintendo.com/jp/switch/ayl8a/index.html'),                                -- メトロイドプライム４ ビヨンド
    (32, 'メトロイドプライム リマスタード', 'https://www.nintendo.com/jp/switch/a3sda/index.html'),                    -- メトロイドプライム４ ビヨンド

    (33, 'ファイアーエムブレム 風花雪月', 'https://www.nintendo.com/jp/switch/anvya/index.html'),                      -- ファイアーエムブレム エンゲージ

    (34, 'ゼノブレイド３', 'https://www.nintendo.com/jp/switch/az3ha/index.html'),                                     -- ゼノブレイドクロス ディフィニティブエディション
    (34, 'ゼノブレイド ディフィニティブ・エディション', 'https://www.nintendo.com/jp/switch/aubqa/index.html'),        -- ゼノブレイドクロス ディフィニティブエディション
    (34, 'ゼノブレイド２', 'https://www.nintendo.com/jp/switch/adena/index.html'),                                     -- ゼノブレイドクロス ディフィニティブエディション

    (35, 'ポケットモンスター ソード・シールド', 'https://www.pokemon.co.jp/ex/sword_shield/'),                -- ポケットモンスター スカーレット・バイオレット
    (35, 'ポケットモンスター ブリリアントダイヤモンド・シャイニングパール', 'https://www.pokemon.co.jp/ex/bdsp/ja/'), -- ポケットモンスター スカーレット・バイオレット
    (35, 'ポケットモンスター ファイアレッド・リーフグリーン', 'https://www.pokemon.co.jp/ex/switch-frlg/'), -- ポケットモンスター スカーレット・バイオレット

    (36, 'Pokémon LEGENDS アルセウス', 'https://www.pokemon.co.jp/ex/legends_arceus/ja/'),                         -- Pokémon LEGENDS Z-A

    (43, 'ベヨネッタ', 'https://www.nintendo.com/jp/bayonetta/1-2/pc/index.html?type=1&cau=1'),                                         -- ベヨネッタ３
    (43, 'ベヨネッタ２', 'https://www.nintendo.com/jp/bayonetta/1-2/index.html'),                                       -- ベヨネッタ３

    (45, 'おすそわける メイド イン ワリオ', 'https://www.nintendo.com/jp/switch/aw7na/index.html'),                    -- 超おどる メイド イン ワリオ

    (59, 'マリオ＋ラビッツ キングダムバトル', 'https://www.nintendo.com/jp/switch/ac2ga/index.html'),                  -- マリオ＋ラビッツ ギャラクシーバトル

    (73, 'かおヨッシー', 'https://store-jp.nintendo.com/item/software/D70010000110451?srsltid=AfmBOoqlpic4_u2lF5nXZlheNNSZHLnbcUM04HgoaaR4n-qiGA8U6xlp'),                                       -- かおマリオ

    (78, 'ファミコン探偵倶楽部 消えた後継者', 'https://www.nintendo.com/jp/switch/aw3ca/famitan1/index.html'),          -- ファミコン探偵倶楽部 笑み男
    (78, 'ファミコン探偵倶楽部 うしろに立つ少女', 'https://www.nintendo.com/jp/switch/aw3ca/famitan2/index.html'),      -- ファミコン探偵倶楽部 笑み男

    -- ============================================================
    -- Nintendo Switch Online クラシック
    -- ============================================================

    (82, 'VS.エキサイトバイク', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haeij/index.html'),                                -- エキサイトバイク
    (82, 'エキサイトバイク64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4238_j/index.html'),                                 -- エキサイトバイク

    (89, 'Tetris®', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-8484_j/index.html'),                                            -- TetrisⓇ
    (89, 'Tetris® DX', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-2648_j/index.html'),                                         -- TetrisⓇ
    (89, '3-Dテトリス®', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-6107_j/index.html'),                                       -- TetrisⓇ

    (92, 'ドクターマリオ (GB版)', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haaxj/index.html'),                              -- ドクターマリオ

    (94, 'バルーンファイトGB', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-7914_j/index.html'),                                  -- バルーンファイト

    (97, 'Kid Icarus: Of Myths and Monsters', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-4927_j/index.html'),                  -- 光神話 パルテナの鏡

    (99, 'ファイアーエムブレム 紋章の謎', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2027_j/index.html'),                      -- ファイアーエムブレム 暗黒竜と光の剣
    (99, 'ファイアーエムブレム 聖戦の系譜', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2028_j/index.html'),                    -- ファイアーエムブレム 暗黒竜と光の剣
    (99, 'ファイアーエムブレム 封印の剣', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-6971_j/index.html'),                      -- ファイアーエムブレム 暗黒竜と光の剣
    (99, 'ファイアーエムブレム 烈火の剣', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-3744_j/index.html'),                      -- ファイアーエムブレム 暗黒竜と光の剣
    (99, 'ファイアーエムブレム 聖魔の光石', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-4331_j/index.html'),                    -- ファイアーエムブレム 暗黒竜と光の剣
    (99, 'ファイアーエムブレム 蒼炎の軌跡', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-1000_j/index.html'),                    -- ファイアーエムブレム 暗黒竜と光の剣

    (103, 'ベースボール (GB版)', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-7618_j/index.html'),                               -- ベースボール

    (104, 'MOTHER2 ギーグの逆襲', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2051_j/index.html'),                              -- MOTHER
    (104, 'MOTHER3', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-4017_j/index.html'),                                           -- MOTHER

    (106, 'マリオゴルフ64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4371_j/index.html'),                                    -- マリオオープンゴルフ
    (106, 'マリオゴルフGB', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-4471_j/index.html'),                                    -- マリオオープンゴルフ

    (109, 'メトロイドⅡ RETURN OF SAMUS', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-1577_j/index.html'),                      -- メトロイド
    (109, 'スーパーメトロイド', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2018_j/index.html'),                                -- メトロイド
    (109, 'メトロイド フュージョン', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-4139_j/index.html'),                           -- メトロイド
    (109, 'メトロイド ゼロミッション', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-6834_j/index.html'),                         -- メトロイド

    (110, 'ヨッシーのたまご (GB版)', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-4825_j/index.html'),                           -- ヨッシーのたまご

    (111, 'レッキングクルー`98', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2096_j/index.html'),                               -- レッキングクルー

    (113, 'F-ZERO X', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-2456_j/index.html'),                                          -- F-ZERO
    (113, 'F-ZERO GX', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-7901_j/index.html'),                                         -- F-ZERO
    (113, 'F-ZERO CLIMAX', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-6553_j/index.html'),                                     -- F-ZERO
    (113, 'F-ZERO ファルコン伝説', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-7842_j/index.html'),                             -- F-ZERO
    (113, 'F-ZERO FOR GAMEBOY ADVANCE', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-9283_j/index.html'),                        -- F-ZERO

    (114, 'カービィのきらきらきっず (GB版)', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-5163_j/index.html'),                   -- カービィのきらきらきっず

    (116, 'スターフォックス2', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2031_j/index.html'),                                 -- スターフォックス
    (116, 'スターフォックス64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3030_j/index.html'),                                -- スターフォックス

    (119, 'マリオカート64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3013_j/index.html'),                                    -- スーパーマリオカート
    (119, 'マリオカートアドバンス', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-6845_j/index.html'),                            -- スーパーマリオカート

    (120, 'パイロットウイングス64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3783_j/index.html'),                            -- パイロットウイングス

    (128, 'カスタムロボV2', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3668_j/index.html'),                                    -- カスタムロボ

    (134, 'ポケモンスタジアム金銀 クリスタルバージョン対応', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3309_j/index.html'),    -- ポケモンスタジアム2

    (140, '黄金の太陽~開かれし封印~', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-3108_j/index.html'),                          -- 黄金の太陽~失われし時代~

    (142, '伝説のスタフィー２', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-5600_j/index.html'),                                -- 伝説のスタフィー
    (142, '伝説のスタフィー３', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-7565_j/index.html'),                                -- 伝説のスタフィー

    (156, '星のカービィ2', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-8212_j/index.html'),                                     -- 星のカービィ
    (156, '星のカービィ 夢の泉の物語', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haapj/index.html'),                       -- 星のカービィ
    (156, '星のカービィ3', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2008_j/index.html'),                                     -- 星のカービィ
    (156, '星のカービィ スーパーデラックス', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2029_j/index.html'),                   -- 星のカービィ
    (156, '星のカービィ64', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3052_j/index.html'),                                    -- 星のカービィ
    (156, '星のカービィ 鏡の大迷宮', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-3654_j/index.html'),                           -- 星のカービィ

    (163, 'ワリオランド3 不思議なオルゴール', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-5928_j/index.html'),                  -- バーチャルボーイ ワリオランド アワゾンの秘宝
    (163, 'ワリオランドアドバンス~ヨーキのお宝~', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-9593_j/index.html'),              -- バーチャルボーイ ワリオランド アワゾンの秘宝

    (170, 'ゼルダの伝説 神々のトライフォース', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2024_j/index.html'),                 -- ゼルダの伝説（クラシック）
    (170, 'ゼルダの伝説 夢をみる島DX', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-3996_j/index.html'),                         -- ゼルダの伝説（クラシック）
    (170, 'ゼルダの伝説 時のオカリナ', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3038_j/index.html'),                         -- ゼルダの伝説（クラシック）
    (170, 'ゼルダの伝説 ふしぎのぼうし', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-8665_j/index.html'),                       -- ゼルダの伝説（クラシック）
    (170, 'ゼルダの伝説 ムジュラの仮面', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-1407_j/index.html'),                       -- ゼルダの伝説（クラシック）
    (170, 'ゼルダの伝説 ふしぎの木の実 大地の章 / 時空の章', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-9130_j/index.html'),  -- ゼルダの伝説（クラシック）

    (173, 'スーパーマリオブラザーズ2', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haabj/index.html'),                         -- スーパーマリオブラザーズ（クラシック）
    (173, 'スーパーマリオブラザーズ3', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haacj/index.html'),                         -- スーパーマリオブラザーズ（クラシック）

    (177, 'スーパードンキーコング2 ディクシー&ディディ', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2060_j/index.html'),       -- スーパードンキーコング（クラシック）
    (177, 'スーパードンキーコング3 謎のクレミス島', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2061_j/index.html'),            -- スーパードンキーコング（クラシック）

    (178, 'ドンキーコングJR.', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haafj/index.html'),                                 -- ドンキーコング（クラシック）

    (179, 'マリオパーティ2', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-1053_j/index.html'),                                   -- マリオパーティ（クラシック）
    (179, 'マリオパーティ3', 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-2965_j/index.html');                                   -- マリオパーティ（クラシック）

GRANT SELECT ON nintendo_suggest.game_similarities TO 'appuser'@'%';
FLUSH PRIVILEGES;
