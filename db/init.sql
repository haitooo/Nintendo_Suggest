SET NAMES utf8mb4;
ALTER DATABASE nintendo_suggest CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS games (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    title           VARCHAR(255) NOT NULL,
    is_retro        BOOLEAN NOT NULL DEFAULT FALSE,
    is_party        BOOLEAN NOT NULL DEFAULT FALSE,
    is_action       BOOLEAN NOT NULL DEFAULT FALSE,
    is_long_play    BOOLEAN NOT NULL DEFAULT FALSE,
    is_hard         BOOLEAN NOT NULL DEFAULT FALSE,
    is_strategic    BOOLEAN NOT NULL DEFAULT FALSE,
    is_story_driven BOOLEAN NOT NULL DEFAULT FALSE,
    is_educational  BOOLEAN NOT NULL DEFAULT FALSE,
    is_sports       BOOLEAN NOT NULL DEFAULT FALSE,
    is_collectible  BOOLEAN NOT NULL DEFAULT FALSE,
    has_similar     BOOLEAN NOT NULL DEFAULT FALSE,
    official_url    VARCHAR(512) DEFAULT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO games (id, title, is_retro, is_party, is_action, is_long_play, is_hard, is_strategic, is_story_driven, is_educational, is_sports, is_collectible, has_similar, official_url) VALUES

-- ============================================================
-- Nintendo Switch / Switch 2
-- ============================================================

-- マリオシリーズ
(1, 'スーパーマリオ オデッセイ', false, false, true, true, false, false, false, false, false, true, true, 'https://www.nintendo.com/jp/switch/aaaca/index.html'),
(2, 'スーパーマリオブラザーズ ワンダー', false, false, true, false, false, false, false, false, false, true, true, 'https://www.nintendo.com/jp/switch/aqmxa/index.html'),
(3, 'スーパーマリオRPG', false, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/a8lua/index.html'),
(4, 'スーパーマリオメーカー 2', false, true, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/baaqa/index.html'),
(5, 'スーパー マリオパーティ ジャンボリー', false, true, false, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/switch/a7hla/index.html'),
(6, 'マリオゴルフ スーパーラッシュ', false, true, false, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/at9ha/index.html'),
(7, 'マリオストライカーズ バトルリーグ', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/awn6a/index.html'),
(8, 'マリオvs.ドンキーコング', false, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/a97pa/index.html'),
(9, 'ペーパーマリオRPG', false, false, false, true, false, true, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/a9qda/index.html'),
(10, 'マリオ＆ルイージRPG ブラザーシップ！', false, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/a8e6a/index.html'),
(11, 'プリンセスピーチ Showtime!', false, false, true, false, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/amjja/index.html'),
(12, '進め！キノピオ隊長', false, false, false, false, false, true, false, false, false, true, false, 'https://www.nintendo.com/jp/switch/ajh9a/index.html'),
(13, 'マリオカート ワールド', false, true, true, false, false, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/switch2/aaaaa/index.html'),
(14, 'マリオテニス フィーバー', false, true, true, false, true, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/switch2/aaaea/index.html'),

-- ゼルダの伝説シリーズ
(15, 'ゼルダの伝説 ティアーズ オブ ザ キングダム', false, false, true, true, true, true, true, false, false, false, true, 'https://www.nintendo.com/jp/zelda/totk/index.html'),
(16, 'ゼルダの伝説 知恵のかりもの', false, false, false, true, true, true, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/bdgea/index.html'),
(17, 'ゼルダ無双 厄災の黙示録', false, false, true, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/character/zelda/yakusai/index.html'),

-- スプラトゥーンシリーズ
(18, 'スプラトゥーン3', false, true, true, false, true, true, false, false, true, false, true, 'https://www.nintendo.com/jp/switch/av5ja/index.html'),

-- 大乱闘スマッシュブラザーズ
(19, '大乱闘スマッシュブラザーズ SPECIAL', false, true, true, false, false, false, false, false, true, false, false, 'https://www.smashbros.com/ja_JP/'),

-- どうぶつの森シリーズ
(20, 'あつまれ どうぶつの森', false, false, false, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/switch/acbaa/index.html'),

-- ルイージマンションシリーズ
(21, 'ルイージマンション２ HD', false, false, true, true, false, false, true, false, false, true, true, 'https://www.nintendo.com/jp/switch/banra/index.html'),

-- カービィシリーズ
(22, '星のカービィ スターアライズ', false, true, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/switch/ah26a/index.html'),
(23, '星のカービィ ディスカバリー', false, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/switch/arzga/index.html'),
(24, 'カービィのグルメフェス', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/a59xa/index.html'),
(25, 'スーパーカービィハンターズ', false, true, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/apy8a/index.html'),
(26, 'カービィファイターズ2', false, true, true, false, true, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/awmfa/index.html'),
(27, 'カービィのエアライダー', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/switch2/aaaba/index.html'),

-- ヨッシーシリーズ
(28, 'ヨッシークラフトワールド', false, false, false, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/switch/aea2a/index.html'),

-- ドンキーコングシリーズ
(29, 'ドンキーコング トロピカルフリーズ', false, false, true, false, true, false, false, false, false, true, true, 'https://www.nintendo.com/jp/switch/afwta/index.html'),
(30, 'ドンキーコング バナンザ', false, false, true, true, true, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/switch2/aaaca/index.html'),

-- ピクミンシリーズ
(31, 'ピクミン４', false, false, false, true, false, true, true, false, false, true, true, 'https://www.nintendo.com/jp/switch/ampya/index.html'),

-- メトロイドシリーズ
(32, 'メトロイドプライム４ ビヨンド', false, false, true, true, true, false, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/bgw5a/index.html'),

-- ファイアーエムブレムシリーズ
(33, 'ファイアーエムブレム エンゲージ', false, false, false, true, true, true, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/ayfna/index.html'),

-- ゼノブレイドシリーズ
(34, 'ゼノブレイドクロス ディフィニティブエディション', false, false, true, true, true, true, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/bas6a/index.html'),

-- ポケモンシリーズ
(35, 'ポケットモンスター スカーレット・バイオレット', false, true, false, true, false, true, true, false, false, true, true, 'https://www.pokemon.co.jp/ex/sv/ja/'),
(36, 'Pokémon LEGENDS Z-A', false, true, true, true, false, true, true, false, false, true, true, 'https://www.pokemon.co.jp/ex/legends_z-a/ja/'),
(37, 'ポケモンクエスト', false, false, false, false, false, false, false, false, false, true, false, 'https://www.pokemon.co.jp/ex/pokemonquest/'),
(38, 'ポケモン不思議のダンジョン 救助隊DX', false, false, false, true, true, true, true, false, false, false, false, 'https://www.pokemon.co.jp/ex/dungeonDX/'),
(39, '帰ってきた 名探偵ピカチュウ', false, false, false, false, false, false, true, false, false, false, false, 'https://www.pokemon.co.jp/ex/detective_pikachu/ja/'),
(40, 'ポケモンフレンズ', false, false, false, false, false, false, false, false, false, true, false, 'https://www.pokemon-friends.jp/'),
(41, 'New ポケモンスナップ', false, false, false, false, false, false, false, false, false, true, false, 'https://www.pokemon.co.jp/ex/newpokemonsnap/'),
(42, 'ポッ拳 DX', false, true, true, false, false, false, false, false, true, false, false, 'https://www.pokemon.co.jp/ex/pokkenDX/'),

-- ベヨネッタシリーズ
(43, 'ベヨネッタ３', false, false, true, false, true, false, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/axb7a/index.html'),
(44, 'ベヨネッタ オリジンズ: セレッサと迷子の悪魔', false, false, true, false, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/axb8a/index.html'),

-- ワリオ・WarioWareシリーズ
(45, '超おどる メイド イン ワリオ', false, true, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/switch/a9qea/index.html'),

-- スニッパーズ
(46, 'いっしょにチョキッと スニッパーズ プラス', false, true, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/switch/aexya/index.html'),

-- ASTRAL CHAIN / コラボタイトル
(47, 'ASTRAL CHAIN', false, false, true, true, true, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/ab48a/index.html'),
(48, '幻影異聞録♯FE Encore', false, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/asa4a/index.html'),
(49, 'Marvel Ultimate Alliance 3: The Black Order', false, true, true, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/apy2a/index.html'),

-- スポーツ・フィットネス
(50, 'ARMS', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/aabqa/index.html'),
(51, 'Nintendo Switch Sports', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/as8sa/index.html'),
(52, 'リングフィット アドベンチャー', false, false, true, true, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/ring/index.html'),
(53, 'TETRIS® 99', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/arzna/index.html'),
(54, 'F-ZERO 99', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/baypa/index.html'),
(55, 'Drag x Drive', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/switch2/aaaqa/index.html'),

-- パーティ・ミニゲーム
(56, '世界のアソビ大全 51', false, true, false, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/as7ta/index.html'),
(57, 'エブリバディ 1-2-Switch!', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/argta/index.html'),
(58, '1-2-Switch', false, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/aacca/index.html'),
(59, 'マリオ＋ラビッツ ギャラクシーバトル', false, false, false, true, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/switch/a4nla/index.html'),

-- パズル・脳トレ
(60, '脳を鍛える大人のNintendo Switchトレーニング', false, false, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/switch/as3ma/index.html'),
(61, 'やわらかあたま塾 いっしょにあたまのストレッチ', false, false, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/switch/azlsa/index.html'),
(62, 'ナビつき！ つくってわかる はじめてゲームプログラミング', false, false, false, true, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/switch/awuxa/index.html'),

-- アドベンチャー・その他
(63, 'Miitopia', false, false, false, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/aw8sa/index.html'),
(64, 'バディミッション BOND', false, false, false, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/aq2fa/index.html'),
(65, 'アナザーコード リコレクション: 2つの記憶/記憶の扉', false, false, false, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/a9rwa/index.html'),
(66, 'フォーエバーブルー ルミナス', false, false, false, true, false, false, false, true, false, true, false, 'https://www.nintendo.com/jp/switch/a7lka/index.html'),
(67, 'Good Job!', false, false, false, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/av99a/index.html'),
(68, 'ストレッチャーズ', false, true, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/an5ea/index.html'),
(69, '超回転 寿司ストライカー', false, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/ala2a/index.html'),
(70, 'DCスーパーヒーローガールズ ティーンパワー', false, false, true, false, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/switch/arxaa/index.html'),
(71, 'ジャンプロープ チャレンジ', false, false, false, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/ayv2a/index.html'),
(72, 'ニンテンドーラボ', false, false, false, true, false, false, false, true, false, false, false, 'https://www.nintendo.com/jp/labo/index.html'),
(73, 'かおマリオ', false, false, false, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/my-mario/app/index.html'),
(74, 'Nintendo Switch 2 のひみつ展', false, false, false, false, false, false, false, true, false, false, false, 'https://www.nintendo.com/jp/games/switch2/aahea/index.html'),
(75, 'ハコボーイ！＆ハコガール！', false, true, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/asspa/index.html'),
(76, 'はたらくUFO', false, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/switch/azd8a/index.html'),

-- ファミコン探偵倶楽部シリーズ
(77, 'Nintendo World Championships ファミコン世界大会', true, true, true, false, true, false, false, false, true, false, false, 'https://www.nintendo.com/jp/switch/a82ca/index.html'),
(78, 'ファミコン探偵倶楽部 笑み男', false, false, false, true, false, false, true, false, false, false, true, 'https://www.nintendo.com/jp/switch/a7lqa/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― ファミリーコンピュータ
-- ============================================================
(79, 'アイスクライマー', true, true, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haauj/index.html'),
(80, 'アイスホッケー', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hactj/index.html'),
(81, 'アーバンチャンピオン', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahtj/index.html'),
(82, 'エキサイトバイク', true, false, true, false, false, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haahj/index.html'),
(83, 'クルクルランド', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haehj/index.html'),
(84, '五目ならべ 連珠', true, true, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahxj/index.html'),
(85, 'ゴルフ', true, false, false, false, false, true, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hajbj/index.html'),
(86, 'サッカー', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hacrj/index.html'),
(87, 'ジョイメカファイト', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hadbj/index.html'),
(88, 'スマッシュピンポン', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hadcj/index.html'),
(89, 'TetrisⓇ', true, false, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-8484_j/index.html'),
(90, 'テニス', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hacyj/index.html'),
(91, 'デビルワールド', true, false, true, false, true, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hajaj/index.html'),
(92, 'ドクターマリオ', true, false, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haaxj/index.html'),
(93, '謎の村雨城', true, false, true, false, true, false, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahvj/index.html'),
(94, 'バルーンファイト', true, true, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haarj/index.html'),
(95, 'バレーボール', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haejj/index.html'),
(96, 'パンチアウト!!(賞品版)', true, false, true, false, true, true, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haatj/index.html'),
(97, '光神話 パルテナの鏡', true, false, true, true, true, false, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haavj/index.html'),
(98, 'ピンボール', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahjj/index.html'),
(99, 'ファイアーエムブレム 暗黒竜と光の剣', true, false, false, true, true, true, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haakj/index.html'),
(100, 'ファミコンウォーズ', true, false, false, true, true, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hadaj/index.html'),
(101, 'ふぁみこんむかし話 新・鬼ヶ島(前後編)', true, false, false, true, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahyj/index.html'),
(102, 'プロレス', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hadlj/index.html'),
(103, 'ベースボール', true, true, true, false, false, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-7618_j/index.html'),
(104, 'MOTHER', true, false, false, true, false, true, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haajj/index.html'),
(105, 'マッハライダー', true, false, true, false, true, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahhj/index.html'),
(106, 'マリオオープンゴルフ', true, false, false, false, false, true, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haamj/index.html'),
(107, 'マリオブラザーズ', true, true, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haawj/index.html'),
(108, '麻雀', true, false, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hahwj/index.html'),
(109, 'メトロイド', true, false, true, true, true, false, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haaqj/index.html'),
(110, 'ヨッシーのたまご', true, false, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haayj/index.html'),
(111, 'レッキングクルー', true, false, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haczj/index.html'),
(112, 'ワリオの森', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hacxj/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― スーパーファミコン
-- ============================================================
(113, 'F-ZERO', true, true, true, false, false, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2005_j/index.html'),
(114, 'カービィのきらきらきっず', true, false, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2172_j/index.html'),
(115, 'カービィボウル', true, false, false, false, false, true, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2007_j/index.html'),
(116, 'スターフォックス', true, false, true, false, true, false, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2011_j/index.html'),
(117, 'すってはっくん', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2136_j/index.html'),
(118, 'スーパーパンチアウト!!', true, false, true, false, true, true, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2019_j/index.html'),
(119, 'スーパーマリオカート', true, true, true, false, false, false, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2016_j/index.html'),
(120, 'パイロットウイングス', true, false, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2009_j/index.html'),
(121, 'パネルでポン', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2034_j/index.html'),
(122, 'マリオとワリオ', true, false, false, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2074_j/index.html'),
(123, 'マリオのスーパーピクロス', true, false, false, true, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2044_j/index.html'),
(124, 'マリオペイント', true, false, false, false, false, false, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2123_j/index.html'),
(125, 'マーヴェラス ~もうひとつの宝島', true, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2030_j/index.html'),
(126, 'ワイルドトラックス', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2012_j/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― NINTENDO 64
-- ============================================================
(127, 'ウエーブレース64', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4813_j/index.html'),
(128, 'カスタムロボ', true, false, true, true, false, true, true, false, false, true, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4093_j/index.html'),
(129, 'ゴールデンアイ007™', true, true, true, false, true, false, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4631_j/index.html'),
(130, 'スーパーマリオ64', true, false, true, true, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3031_j/index.html'),
(131, '罪と罰 地球の継承者', true, false, true, false, true, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3029_j/index.html'),
(132, 'テン・エイティ スノーボーディング', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-1653_j/index.html'),
(133, 'ブラストドーザー', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3083_j/index.html'),
(134, 'ポケモンスタジアム2', true, true, false, false, false, true, false, false, true, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4590_j/index.html'),
(135, 'ポケモンスナップ', true, false, false, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3240_j/index.html'),
(136, 'マリオストーリー', true, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-2992_j/index.html'),
(137, 'マリオテニス64', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3017_j/index.html'),
(138, 'ヨッシーストーリー', true, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-3036_j/index.html'),
(139, 'Ridge Racer™64', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-1730_j/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― ゲームボーイアドバンス
-- ============================================================
(140, '黄金の太陽~失われし時代~', true, false, false, true, false, true, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-8978_j/index.html'),
(141, 'くるくるくるりん', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-7279_j/index.html'),
(142, '伝説のスタフィー', true, false, true, false, false, false, false, false, false, true, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-9694_j/index.html'),
(143, 'ポケモン不思議のダンジョン 赤の救助隊', true, false, false, true, true, true, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-8989_j/index.html'),
(144, 'マジカルバケーション', true, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-2973_j/index.html'),
(145, 'マリオ&ルイージRPG', true, false, false, true, false, true, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-7311_j/index.html'),
(146, 'マリオvs.ドンキーコング', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/character/mario/history/vsdonkey/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― ゲームボーイ / ゲームボーイカラー
-- ============================================================
(147, 'アレイウェイ', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-6879_j/index.html'),
(148, 'カエルの為に鐘は鳴る', true, false, true, false, false, false, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-7296_j/index.html'),
(150, 'ゲームボーイギャラリー3', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-3381_j/index.html'),
(151, 'コロコロカービィ', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-0282_j/index.html'),
(152, 'スーパーマリオランド', true, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-7970_j/index.html'),
(153, 'スーパーマリオランド26つの金貨', true, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-5124_j/index.html'),
(154, 'ドクターマリオ', true, false, false, false, false, true, false, false, false, false, false, 'https://www.nintendo.co.jp/n02/dmg/vua/index.html'),
(155, 'ベースボール', true, true, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-hadpj/index.html'),
(156, '星のカービィ', true, false, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-5661_j/index.html'),
(157, 'ポケモンカードGB', true, false, false, true, false, true, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/c-3191_j/index.html'),
(158, 'マリオのピクロス', true, false, false, true, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-1974_j/index.html'),
(159, '役満', true, false, false, false, false, true, false, true, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/d-1504_j/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― バーチャルボーイ
-- ============================================================
(161, 'ギャラクティック・ピンボール', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-3032_j/index.html'),
(162, 'テレロボクサー', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-5149_j/index.html'),
(163, 'バーチャルボーイ ワリオランド アワゾンの秘宝', true, false, true, false, false, false, false, false, false, true, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-9378_j/index.html'),
(164, 'マリオクラッシュ', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-7297_j/index.html'),
(165, 'マリオズテニス', true, false, true, false, false, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/v-8903_j/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― ゲームキューブ
-- ============================================================
(166, 'スーパーマリオストライカーズ', true, true, true, false, true, false, false, false, true, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-1867_j/index.html'),
(167, 'ちびロボ!', true, false, true, true, true, false, true, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-4879_j/index.html'),
(168, 'ポケモンXD 闇の旋風ダーク・ルギア', true, false, false, true, false, true, true, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-8163_j/index.html'),
(169, 'ワリオワールド', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/g-6370_j/index.html'),

-- ============================================================
-- Nintendo Switch Online クラシック ― シリーズ
-- ============================================================
(170, 'ゼルダの伝説（クラシック）', true, false, true, true, true, true, true, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haanj/index.html'),
(171, 'リンクの冒険', true, false, true, true, true, false, true, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haasj/index.html'),
(172, 'ゼルダの伝説 4つの剣', true, true, true, false, false, true, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/a-5190_j/index.html'),
(173, 'スーパーマリオブラザーズ（クラシック）', true, false, true, false, false, false, false, false, false, true, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haaaj/index.html'),
(174, 'スーパーマリオUSA', true, false, true, false, false, false, false, false, false, false, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haadj/index.html'),
(175, 'スーパーマリオワールド（クラシック）', true, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2017_j/index.html'),
(176, 'スーパーマリオワールド2 ヨッシーアイランド', true, false, true, false, false, false, false, false, false, true, false, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2023_j/index.html'),
(177, 'スーパードンキーコング（クラシック）', true, false, true, false, true, false, false, false, false, true, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/s-2055_j/index.html'),
(178, 'ドンキーコング（クラシック）', true, false, true, false, false, false, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/clv-p-haaej/index.html'),
(179, 'マリオパーティ（クラシック）', true, true, false, false, false, true, false, false, false, false, true, 'https://www.nintendo.com/jp/games/feature/nintendo-classics/n-4737_j/index.html');

-- アプリ用ユーザーを SELECT 権限のみで作成
CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'password';
GRANT SELECT ON nintendo_suggest.games TO 'appuser'@'%';
FLUSH PRIVILEGES;
