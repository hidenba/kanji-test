require 'sinatra'
require 'sinatra/reloader'

WORDS = [
  {text: 'しを書く', target: 'し'}, {text: '外国のしじん', target: 'し'},
  {text: 'げきの一場めん', target: 'めん'}, {text: '地めんに水をまく', target: 'めん'},
  {text: 'げきにとう場する', target: 'とう'},  {text: 'やまにのぼる', target: 'のぼる'},
  {text: 'りっぱな人ぶつ', target: 'ぶつ'},  {text: 'もの語りの人気者', target: 'もの'},
  {text: 'しょう売をする', target: 'しょう'},  {text: 'しょう人の町', target: 'しょう'},
  {text: '本をひらく', target: 'ひらく'},  {text: '戸をあける', target: 'あける'}, {text: 'お店のかい店時間', target: 'かい'},
  {text: '家ぞくで出かける', target: 'ぞく'},  {text: '水ぞく館に行く', target: 'ぞく'},
  {text: 'はがしげる', target: 'は'},  {text: '落ようのきせつ', target: 'よう'},
  {text: 'クリのみがなる', target: 'み'},  {text: 'じつ話', target: 'じつ'}, {text: 'ももがみのる', target: 'みのる'},
  {text: '座る場しょ', target: 'しょ'},  {text: '広いところにうつる', target: 'ところ'},
  {text: '国語の学しゅう', target: 'しゅう'},  {text: 'ピアノをならう', target: 'ならう'}, {text: 'しゅうじの授業', target: 'しゅうじ'},
  {text: '車がうごく', target: 'うごく'},  {text: 'どう物園に行く', target: 'どう'},
  {text: '四ぶ音符の長さ', target: 'ぶ'},
  {text: 'けさのできごと', target: 'けさ'},
  {text: '声のきょうじゃく', target: 'きょうじゃく'},
  {text: 'ことばをおぼえる', target: 'ことば'},
  {text: '少しまをとる', target: 'ま'},
  {text: 'ふたりで話す', target: 'ふたり'},
  {text: 'い外なけっか', target: 'い'}, {text: '髪をよういする', target: 'ようい'},
  {text: '言葉の意み', target: 'み'},  {text: 'しおあじ', target: 'あじ'},
  {text: 'かんじを読む', target: 'かんじ'},  {text: 'かん数字で書く', target: 'かん'},
  {text: '意味をしらべる', target: 'しらべる'},  {text: '体ちょうがいい', target: 'ちょう'},
  {text: 'じゆうに話す', target: 'じゆう'},  {text: '地名のゆ来', target: 'ゆ'},
  {text: 'もんだいと答え', target: 'もんだい'},  {text: 'わけをとう', target: 'とう'},
  {text: 'てすとの問だい', target: 'だい'},  {text: '楽しい話だい', target: 'だい'},
  {text: 'あたたかいスープ', target: 'あたたかい'},  {text: 'きおんをはかる', target: 'きおん'},
  {text: 'あまざけをのむ', target: 'ざけ'},  {text: 'さかやに行く', target: 'さかや'},  {text: 'ぶどうしゅをのむ', target: 'しゅ'},
  {text: 'つぎの電車に乗る', target: 'つぎ'},  {text: 'じかいのおたのしみ', target: 'じかい'},  {text: 'あいつぐ', target: 'あいつぐ'},
  {text: 'はさみをつかう', target: 'つかう'},  {text: '電気をしようする', target: 'しよう'},
  {text: '図に書きあらわす', target: 'あらわす'},  {text: 'ひょうしのしゃしん', target: 'ひょうし'},  {text: '紙のおもて', target: 'おもて'},
  {text: '正しくはつ音する', target: 'はつ'},  {text: 'ピアノのはっぴょうかい', target: 'はっぴょうかい'},
  {text: '文のしゅご', target: 'しゅご'},  {text: '落とし物のもちぬし', target: 'ぬし'}, {text: 'おもなとうじょうじんぶつ', target: 'とうじょうじんぶつ'},
  {text: '一分は六十びょう', target: 'びょう'},  {text: 'びょうよみみのだんかい', target: 'びょうよみ'},
  {text: 'こおりがとける', target: 'こおり'},  {text: 'ひょうてんかの気温', target: 'ひょうてんか'},
  {text: 'のうかのしごと', target: 'のうか'},  {text: 'のう作物をそだてる', target: 'のう'},
  {text: 'ゆうびんきょくの前', target: 'きょく'},  {text: '電話のしがいきょくばん', target: 'しがいきょくばん'},
  {text: 'うちがわ', target: 'うち'},
  {text: 'にんぎょう', target: 'にんぎょう'},
  {text: 'ちょうしょく', target: 'ちょうしょく'},
  {text: 'そうちょう', target: 'そうちょう'},
  {text: 'いっぷん', target: 'いっぷん'},
  {text: 'ふなびと', target: 'ふなびと'},
  {text: '一年をふりかえる', target: 'かえる'},  {text: '手紙でへん答する', target: 'へん'},
  {text: '心にきめる', target: 'きめる'},  {text: 'けついをかためるｊ', target: 'けつい'},
  {text: 'きょうのできごと', target: 'できごと'},  {text: 'だいじなこと', target: 'じ'},
  {text: '人の気はいがする', target: 'はい'},  {text: '新聞をくばる', target: 'くばる'},
  {text: 'ゆう名な人', target: 'ゆう'},  {text: 'ありあまる力', target: 'あり'},
  {text: '電話のあいて', target: 'あいて'},  {text: '手そうを見る', target: 'そう'},
  {text: 'スピードをおとす', target: 'おとす'},  {text: 'らく葉した木', target: 'らく'},
  {text: 'うわぎをとる', target: 'うわぎ'},  {text: 'ちゃく地する', target: 'ちゃく'}, {text: '学校につく', target: 'つく'},
  {text: 'よう食を食べる', target: 'よう'},  {text: 'せいようの文化', target: 'せいよう'},
  {text: 'ようふくを着る', target: 'ようふく'},  {text: '夏ふくに着がえる', target: 'ふく'},
  {text: 'しんぶん', target: 'しんぶん'},
  {text: 'はっけん', target: 'はっけん'},
  {text: 'ひとり', target: 'ひとり'},
  {text: 'あす', target: 'あす'},
  {text: 'せいざを見る', target: 'せいざ'},
  {text: 'あかるい', target: 'あかるい'},
  {text: '友だちとあそぶ', target: 'あそぶ'},  {text: 'ゆう園地へ行く', target: 'ゆう'},
  {text: 'みじかいロープ', target: 'みじかい'},  {text: 'たん文を書く', target: 'たん'},
  {text: 'せ間話をする', target: 'せ'},  {text: '六せい紀', target: 'せい'}, {text: 'よの中', target: 'よ'},
  {text: '世かいの国々', target: 'かい'},  {text: '一面の銀世かい', target: 'かい'},
  {text: 'ゆびをまげる', target: 'ゆび'},  {text: 'しめいする', target: 'しめい'}, {text: '北をさす', target: 'さす'},
  {text: '地下てつに乗る', target: 'てつ'},  {text: 'てつぼうで遊ぶ', target: 'てつ'},
  {text: 'あんしんして休む', target: 'あんしん'},  {text: 'ねだんがやすい店', target: 'やすい'},
  {text: 'あんていした生活', target: 'あんてい'},  {text: 'じょう規', target: 'じょう'},  {text: '国でさだめる', target: 'さだめる'},
  {text: 'ようすをうががす', target: 'ようす'},  {text: 'おうさまに従う', target: 'おうさま'},
  {text: 'ぶんしょうを書く', target: 'ぶんしょう'},  {text: '物語のだいいっしょう', target: 'だいいっしょう'},
  {text: 'さくひんを並べる', target: 'さくひん'},  {text: 'しな物を買う', target: 'しな'},
  {text: 'おこなう', target: 'おこなう'},
  {text: 'ようす', target: 'ようす'},
  {text: 'ちょうし', target: 'ちょうし'},
  {text: 'ひがしの空', target: 'ひがし'},
  {text: 'じょうず', target: 'じょうず'},
  {text: '落ち葉をあつめる', target: 'あつめる'},  {text: 'テストにしゅうちゅうする', target: 'しゅうちゅう'},
  {text: '地図の記ごう', target: 'ごう'},  {text: '電話番ごうをきく', target: 'ごう'},
  {text: '通学ろを通る', target: 'ろ'},  {text: '家じをいそぐ', target: 'じ'},
  {text: 'よこ書きの文章', target: 'よこ'},  {text: '車がおう転する', target: 'おう'},
  {text: '夏がおわる', target: 'おわる'},  {text: 'しゅう点でおりる', target: 'しゅう'},
  {text: 'ぎん行へ行く', target: 'ぎん'},  {text: 'ぎん色のかさ', target: 'ぎん'},
  {text: 'きょ年の夏休み', target: 'きょ'},  {text: '町をさる', target: 'さる'},
  {text: '毛ひつで書く', target: 'ひつ'},  {text: '絵ふでを買う', target: 'ふで'},
  {text: '入学しきの日', target: 'しき'},  {text: '正しきに発表する', target: 'しき'},
  {text: 'ちょくせん', target: 'ちょくせん'},
  {text: 'たなばた', target: 'たなばた'},
  {text: 'きんじょ', target: 'きんじょ'},
  {text: '句とう点', target: 'とう'},
  {text: 'つう学路', target: 'つう'},
  {text: 'せい天', target: 'せい'},
  {text: 'うれしいきもち', target: 'きもち'},  {text: '所じ品', target: 'じ'},
  {text: 'にわをはく', target: 'にわ'},  {text: '校ていで遊ぶ', target: 'てい'},
  {text: '学校へいそぐ', target: 'いそぐ'},  {text: 'きゅう用ができる', target: 'きゅう'},
  {text: '米やさんの店先', target: 'や'},  {text: 'おく上に集まる', target: 'おく'},
  {text: '商売をはじめる', target: 'はじめる'},  {text: '開しの合図', target: 'し'},
  {text: '空がくらくなる', target: 'くらく'},  {text: '文をあん記する', target: 'あん'},
  {text: '水がながれる', target: 'ながれる'},  {text: 'りゅう行の音楽', target: 'りゅう'},
  {text: '雨やどりをりをする', target: 'やど'},  {text: '算数のしゅく題', target: 'しゅく'},
  {text: '安ぜんを守る', target: 'ぜん'},  {text: 'まったく知らない', target: 'まったく'}, {text: 'すべて', target: 'すべて'},
  {text: '全ぶできる', target: 'ぶ'},  {text: '体のぶ分', target: 'ぶ'},
  {text: 'おれいの気持ち', target: 'れい'},  {text: '朝れいの時間', target: 'れい'},
  {text: '中おうにある公園', target: 'おう'},  {text: 'ちゅうおう公園に行く', target: 'ちゅうおう'},
  {text: '妹のかわり', target: 'かわり'},  {text: '交たいする', target: 'たい'},
  {text: '京のみやこ', target: 'みやこ'},  {text: '東京と', target: 'と'}, {text: 'つごうがわるい', target: 'つごう'},
  {text: '三ちょう目の家', target: 'ちょう'},  {text: 'とうふをいっちょう買う', target: 'いっちょう'},
  {text: 'ていくう飛行', target: 'ていくう'},
  {text: '町田し', target: 'し'},
  {text: 'ついたち', target: 'ついたち'}  ,
  {text: '図書かんへ行く', target: 'かん'},  {text: 'やかたのあるじ', target: 'やかた'},
  {text: '親に相だんする', target: 'だん'},  {text: '市長と会だんする', target: 'だん'},
  {text: '花をしゃ生する', target: 'しゃ'},  {text: '文を書きうつす', target: 'うつす'},
  {text: '写しんを取る', target: 'しん'},  {text: 'まっしろな雪', target: 'まっしろ'},
  {text: 'し事を始める', target: 'し'},  {text: '王様につかえる', target: 'つかえる'},
  {text: 'こ上に浮かぶ船', target: 'こ'},  {text: 'おおきなみずうみ', target: 'みずうみ'},
  {text: '山口けんの名物', target: 'けん'},  {text: 'けん内にある学校', target: 'けん'},
  {text: 'みどり色の虫', target: 'みどり'},  {text: 'りょく茶を飲む', target: 'りょく'},
  {text: '青い屋ねの家', target: 'ね'},  {text: '大こんを食べてる', target: 'こん'},
  {text: 'きょく線を描く', target: 'きょく'},  {text: '左にまがる', target: 'まがる'},
  {text: '魚がおよぐ', target: 'およぐ'},  {text: '水えい大会に出る', target: 'えい'},
  {text: '大切な生活用ぐ', target: 'ぐ'},  {text: '雨ぐを用意する', target: 'ぐ'},
  {text: '定き的に見る', target: 'き'},  {text: '新学きが始まる', target: 'き'},
  {text: 'こんちゅう', target: 'ちゅう'},
  {text: '科もく', target: 'もく'},
  {text: 'しるす', target: 'しるす'},
  {text: 'ふう景', target: 'ふう'},
  {text: 'やちょう', target: 'やちょう'},
  {text: 'もちいる', target: 'もちいる'},
  {text: 'りょう手で持つ', target: 'りょう'},  {text: 'りょう親とでかける', target: 'りょう'},
  {text: '発表会のしん行', target: 'しん'},  {text: '話し合いをすすめる', target: 'すすめる'},
  {text: 'ちかくの児どう館', target: 'どう'},  {text: 'どう話を読む', target: 'どう'},
  {text: '光がはん射する', target: 'はん'},  {text: 'いたがそる', target: 'そる'},
  {text: '反たいの方向', target: 'たい'},  {text: '親子のたい話', target: 'たい'},
  {text: 'サッカーのれん習', target: 'れん'},  {text: '計画をねる', target: 'ねる'},
  {text: '先生のじょ言', target: 'じょ'},  {text: '友だちをたすける', target: 'たすける'},
  {text: '車にちゅう意する', target: 'ちゅう'},  {text: '水をそそぐ', target: 'そそぐ'},
  {text: 'ふかい海の底', target: 'ふかい'},  {text: '水しんをはかる', target: 'しん'},
  {text: '二つにく切る', target: 'く'},  {text: '雪の多い地く', target: 'く'},
  {text: 'いっぽ前に出る', target: 'いっぽ'},
  {text: '発げんする', target: 'げん'},
  {text: 'ことし', target: 'ことし'},
]

get '/' do
  haml :index, locals: {words: WORDS.sample(50)}
end
