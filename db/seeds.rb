require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーデータ作成
User.find_or_create_by!(email: "taro@example.com") do |user|
  user.nickname = "たろう"
  user.password = "testtaro"
end

# レシピカテゴリー作成
categories = [
  { category_id: "30", name: "人気メニュー" },
  { category_id: "31", name: "定番の肉料理" },
  { category_id: "32", name: "定番の魚料理" },
  { category_id: "33", name: "卵料理" },
  { category_id: "14", name: "ご飯もの" },
  { category_id: "15", name: "パスタ" },
  { category_id: "16", name: "麺・粉物料理" },
  { category_id: "17", name: "汁物・スープ" },
  { category_id: "23", name: "鍋料理" },
  { category_id: "18", name: "サラダ" },
  { category_id: "22", name: "パン" },
  { category_id: "21", name: "お菓子" },
  { category_id: "10", name: "肉" },
  { category_id: "11", name: "魚" },
  { category_id: "12", name: "野菜" },
  { category_id: "34", name: "果物" },
  { category_id: "19", name: "ソース・調味料・ドレッシング" },
  { category_id: "27", name: "飲みもの" },
  { category_id: "35", name: "大豆・豆腐" },
  { category_id: "13", name: "その他の食材" },
  { category_id: "20", name: "お弁当" },
  { category_id: "36", name: "簡単料理・時短" },
  { category_id: "37", name: "節約料理" },
  { category_id: "38", name: "今日の献立" },
  { category_id: "39", name: "健康料理" },
  { category_id: "40", name: "調理器具" },
  { category_id: "26", name: "その他の目的・シーン" },
  { category_id: "41", name: "中華料理" },
  { category_id: "42", name: "韓国料理" },
  { category_id: "43", name: "イタリア料理" },
  { category_id: "44", name: "フランス料理" },
  { category_id: "25", name: "西洋料理" },
  { category_id: "46", name: "エスニック料理・中南米" },
  { category_id: "47", name: "沖縄料理" },
  { category_id: "48", name: "日本各地の郷土料理" },
  { category_id: "24", name: "行事・イベント" },
  { category_id: "49", name: "おせち料理" },
  { category_id: "50", name: "クリスマス" },
  { category_id: "51", name: "ひな祭り" },
  { category_id: "52", name: "春（3月～5月）" },
  { category_id: "53", name: "夏（6月～8月）" },
  { category_id: "54", name: "秋（9月～11月）" },
  { category_id: "55", name: "冬（12月～2月）" }
]

categories.each do |category|
  RecipeCategory.find_or_create_by!(category)
end

# レシピデータ作成
Recipe.find_or_create_by!(user_id: 1, name: "5分で速攻！もやしだけdeとん平焼き☆") do |recipe|
  recipe.recipe_category_id = 24
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/b216d4165833f64571894763c033c668452cd2b1.20.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "b216d4165833f64571894763c033c668452cd2b1.20.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1720024883/"
  recipe.poster_name = "かばちゃーん"
  recipe.cook_time = "5分以内"
  recipe.cost = "100円以下"
  recipe.foodstuff_name = "[\"もやし\", \"卵\", \"塩胡椒\", \"おたふくソース（お好み焼きソース）\", \"マヨネーズ\", \"お好きなトッピング(葱・鰹節・青のり等)\"]"
  recipe.memo = "おいしかった。"
  recipe.star = 3
end

Recipe.find_or_create_by!(user_id: 1, name: "簡単☆本格ハンバーグソース") do |recipe|
  recipe.recipe_category_id = 1
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/50fe37bda3c657b77f2842d28727ceb3e8d89f4e.31.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "50fe37bda3c657b77f2842d28727ceb3e8d89f4e.31.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1570003792/"
  recipe.poster_name = "LUKママ"
  recipe.cook_time = "指定なし"
  recipe.cost = "指定なし"
  recipe.foodstuff_name = "[\"ケチャップ\", \"ソース\", \"バター\", \"砂糖\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 4
end

Recipe.find_or_create_by!(user_id: 1, name: "主人が、いくらでも食べれると絶賛のナス・ピーマン") do |recipe|
  recipe.recipe_category_id = 1
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/eb2f27f434436225566c034083f98ddf2aaa0a50.50.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "eb2f27f434436225566c034083f98ddf2aaa0a50.50.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1290001623/"
  recipe.poster_name = "ライム2141"
  recipe.cook_time = "約10分"
  recipe.cost = "100円以下"
  recipe.foodstuff_name = "[\"長ナス\", \"ピーマン\", \"砂糖\", \"醤油\", \"ゴマ油orサラダ油\", \"だしの素\", \"白いりゴマ\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 5
end

Recipe.find_or_create_by!(user_id: 1, name: "水切りなし♡豆腐でボリューム♡ふわふわ鶏つくね") do |recipe|
  recipe.recipe_category_id = 2
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/9351681bba5daf05f49e4dc081599e7acc48fed2.69.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "9351681bba5daf05f49e4dc081599e7acc48fed2.69.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1670008437/"
  recipe.poster_name = "mino(・´｀●)"
  recipe.cook_time = "約15分"
  recipe.cost = "300円前後"
  recipe.foodstuff_name = "[\"＜つくねの材料＞\", \"鶏挽肉\", \"豆腐\", \"玉ねぎ\", \"片栗粉\", \"鶏がらスープの素\", \"塩\", \"＜タレの材料＞\", \"砂糖\", \"酒\", \"醤油\", \"みりん\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 4
end

Recipe.find_or_create_by!(user_id: 1, name: "豚ひき肉で作る、照り焼き風つくね！") do |recipe|
  recipe.recipe_category_id = 2
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/a33a1ac89c3e3605103b02036f20c5d50143edc0.00.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "a33a1ac89c3e3605103b02036f20c5d50143edc0.00.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1620023735/"
  recipe.poster_name = "Asiantree❤︎"
  recipe.cook_time = "約15分"
  recipe.cost = "300円前後"
  recipe.foodstuff_name = "[\"●豚ひき肉\", \"●玉ねぎ\", \"●卵\", \"●生姜すりおろし\", \"●塩胡椒\", \"●片栗粉\", \"★酒\", \"★醤油\", \"★みりん\", \"★砂糖\", \"★片栗粉\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 5
end

Recipe.find_or_create_by!(user_id: 1, name: "魚屋さんが教えてくれた カレイの煮付け") do |recipe|
  recipe.recipe_category_id = 3
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/862cd72bae056544418aba5cf0e0dc34ebeeb1d9.15.9.3.3.jpg"
  file = URI.open(recipe_image)
  file_name = "862cd72bae056544418aba5cf0e0dc34ebeeb1d9.15.9.3.3.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1790017077/"
  recipe.poster_name = "おやじ飯 Oyaji's kitchen︎"
  recipe.cook_time = "約15分"
  recipe.cost = "指定なし"
  recipe.foodstuff_name = "[\"カレイ切り身\", \"塩(臭み取り用)\", \"❏煮汁\", \"しょう油\", \"みりん\", \"料理酒\", \"砂糖\", \"水\"]"
  recipe.memo = "おいしかった。調理がちょっと面倒。"
  recipe.star = 3
end

Recipe.find_or_create_by!(user_id: 1, name: "まるでフォアグラ！鮭の白子バター醤油焼き") do |recipe|
  recipe.recipe_category_id = 3
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/ca45872ad5d20c3a0210650230abe40b41e7dd63.93.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "ca45872ad5d20c3a0210650230abe40b41e7dd63.93.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1510023601/"
  recipe.poster_name = "M@H︎"
  recipe.cook_time = "約15分"
  recipe.cost = "300円前後"
  recipe.foodstuff_name = "[\"鮭白子\", \"塩(下処理)\", \"豆苗\", \"片栗粉\", \"バター\", \"オリーブオイル\", \"料理酒\", \"醤油\"]"
  recipe.memo = "おいしかった。下処理が面倒。"
  recipe.star = 3
end

Recipe.find_or_create_by!(user_id: 1, name: "tiktokで話題沸騰中！【やみつきたまご】") do |recipe|
  recipe.recipe_category_id = 4
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/520c02b4f1642a517969a2b3782fc95303aec301.18.9.3.3.jpg"
  file = URI.open(recipe_image)
  file_name = "520c02b4f1642a517969a2b3782fc95303aec301.18.9.3.3.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1070062995/"
  recipe.poster_name = "KZ COOKING CHANNEL︎"
  recipe.cook_time = "約15分"
  recipe.cost = "300円前後"
  recipe.foodstuff_name = "[\"卵\", \"〜麻薬卵だれ〜\", \"☆玉ねぎ（みじん切り）\", \"☆万能ねぎ（小口切り）\", \"☆輪切り唐辛子\", \"☆めんつゆ\", \"☆水\", \"☆しょうゆ\", \"☆砂糖\", \"☆白ゴマ\", \"☆にんにくチューブ\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 5
end

Recipe.find_or_create_by!(user_id: 1, name: "プロ直伝！ニラともやしの卵炒め") do |recipe|
  recipe.recipe_category_id = 4
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/470d7126e612f8c2c2bd49bda6ec71c57cb8fa5f.46.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "470d7126e612f8c2c2bd49bda6ec71c57cb8fa5f.46.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1050010995/"
  recipe.poster_name = "uzuratukune3︎"
  recipe.cook_time = "約10分"
  recipe.cost = "100円以下"
  recipe.foodstuff_name = "[\"ニラ\", \"もやし\", \"卵\", \"マヨネーズ\", \"塩・こしょう\", \"おろしニンニク\", \"おろししょうが\", \"★オイスターソース\", \"★醤油\", \"ゴマ油\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 4
end

Recipe.find_or_create_by!(user_id: 1, name: "レンジで簡単♪我が家の“ハムエッグ”") do |recipe|
  recipe.recipe_category_id = 4
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/8b591a78d29f7e60d1535faa5fe6dd152d1bd7e9.98.2.3.2.jpg"
  file = URI.open(recipe_image)
  file_name = "8b591a78d29f7e60d1535faa5fe6dd152d1bd7e9.98.2.3.2.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1140023346/"
  recipe.poster_name = "miyu71174︎"
  recipe.cook_time = "5分以内"
  recipe.cost = "100円以下"
  recipe.foodstuff_name = "[\"卵\", \"スライスハム\", \"コショウ\"]"
  recipe.memo = "シンプルisベスト"
  recipe.star = 3
end

Recipe.find_or_create_by!(user_id: 1, name: "3合用★おかわり確実！昔ながらの炊き込みご飯") do |recipe|
  recipe.recipe_category_id = 5
  recipe_image = "https://image.space.rakuten.co.jp/d/strg/ctrl/3/89bc73e0b122856e5b1c0751a2be5209fe8712f2.84.9.3.3.jpg"
  file = URI.open(recipe_image)
  file_name = "89bc73e0b122856e5b1c0751a2be5209fe8712f2.84.9.3.3.jpg"
  recipe.recipe_image.attach(io: file, filename: file_name)
  recipe.url = "https://recipe.rakuten.co.jp/recipe/1850018095/"
  recipe.poster_name = "momomo_︎"
  recipe.cook_time = "約1時間"
  recipe.cost = "300円前後"
  recipe.foodstuff_name = "[\"米\", \"ごぼう\", \"人参\", \"しいたけ\", \"油揚げ\", \"糸こんにゃく\", \"●しょうゆ\", \"●酒\", \"●砂糖\", \"●顆粒だし\", \"水\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 5
end

# レシピのお気に入り作成
recipe_favorites = [
  { user_id: 1, recipe_id: 2 },
  { user_id: 1, recipe_id: 3 },
  { user_id: 1, recipe_id: 4 },
  { user_id: 1, recipe_id: 5 },
  { user_id: 1, recipe_id: 8 },
  { user_id: 1, recipe_id: 9 },
  { user_id: 1, recipe_id: 11 }
]

recipe_favorites.each do |recipe_favorite|
  RecipeFavorite.find_or_create_by!(recipe_favorite)
end

# お店ジャンル作成
genres = [
  { genre_code: "G001", name: "居酒屋" },
  { genre_code: "G002", name: "ダイニングバー・バル" },
  { genre_code: "G003", name: "創作料理" },
  { genre_code: "G004", name: "和食" },
  { genre_code: "G005", name: "洋食" },
  { genre_code: "G006", name: "イタリアン・フレンチ" },
  { genre_code: "G007", name: "中華" },
  { genre_code: "G008", name: "焼肉・ホルモン" },
  { genre_code: "G017", name: "韓国料理" },
  { genre_code: "G009", name: "アジア・エスニック料理" },
  { genre_code: "G010", name: "各国料理" },
  { genre_code: "G011", name: "カラオケ・パーティ" },
  { genre_code: "G012", name: "バー・カクテル" },
  { genre_code: "G013", name: "ラーメン" },
  { genre_code: "G016", name: "お好み焼き・もんじゃ" },
  { genre_code: "G014", name: "カフェ・スイーツ" },
  { genre_code: "G015", name: "その他グルメ" }
]

genres.each do |genre|
  RestaurantGenre.find_or_create_by!(genre)
end

# お店データ作成
Restaurant.find_or_create_by!(user_id: 1, name: "韓国居酒屋 KAD ATA カドアタ") do |restaurant|
  restaurant.restaurant_genre_id = 9
  restaurant_image = "https://imgfp.hotp.jp/IMGH/77/21/P038207721/P038207721_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P038207721_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ000981495/?vos=nhppalsa000016"
  restaurant.address = "長野県長野市鶴賀上千歳町1352小玉屋ビル1F"
  restaurant.open_time = "月～日、祝日、祝前日: 17:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:00）"
  restaurant.legular_holiday = "なし"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 5
end

Restaurant.find_or_create_by!(user_id: 1, name: "創作鳥料理 鶏っく 梅田東通り店") do |restaurant|
  restaurant.restaurant_genre_id = 1
  restaurant_image = "https://imgfp.hotp.jp/IMGH/01/49/P042450149/P042450149_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P042450149_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ000990027/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市北区堂山町7-7 角庄ビル7F"
  restaurant.open_time = "月～日、祝日、祝前日: 17:00～翌0:00 （料理L.O. 23:00 ドリンクL.O. 23:30）"
  restaurant.legular_holiday = "なし"
  restaurant.memo = "おいしかった。"
  restaurant.star = 3
end

Restaurant.find_or_create_by!(user_id: 1, name: "味の大丸 新世界店") do |restaurant|
  restaurant.restaurant_genre_id = 1
  restaurant_image = "https://imgfp.hotp.jp/IMGH/64/42/P041016442/P041016442_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P041016442_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001134122/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市浪速区恵美須東３‐１‐１５ 新世界エリア"
  restaurant.open_time = "月～日、祝日、祝前日: 11:00～21:00 （料理L.O. 20:00 ドリンクL.O. 20:00）"
  restaurant.legular_holiday = "定休日無し"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 4
end

Restaurant.find_or_create_by!(user_id: 1, name: "和牛焼肉 牛WAKA丸") do |restaurant|
  restaurant.restaurant_genre_id = 1
  restaurant_image = "https://imgfp.hotp.jp/IMGH/71/69/P040977169/P040977169_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P040977169_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001164415/?vos=nhppalsa000016"
  restaurant.address = "東京都港区新橋６-10-3 アパホテル新橋御成門 1F"
  restaurant.open_time = "月～金: 11:30～14:00 （料理L.O. 13:30 ドリンクL.O. 13:30）17:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:00）土、祝日: 17:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:00）"
  restaurant.legular_holiday = "日"
  restaurant.memo = "おいしかった。"
  restaurant.star = 3
end

Restaurant.find_or_create_by!(user_id: 1, name: "TUFFE トゥッフェ 大丸心斎橋店") do |restaurant|
  restaurant.restaurant_genre_id = 2
  restaurant_image = "https://imgfp.hotp.jp/IMGH/98/86/P038299886/P038299886_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P038299886_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001225255/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市中央区心斎橋筋１-7-1　7F"
  restaurant.open_time = "月～日、祝日、祝前日: 11:00～22:00 （料理L.O. 21:00 ドリンクL.O. 21:00）"
  restaurant.legular_holiday = "大丸心斎橋本館の休業日"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 5
end

Restaurant.find_or_create_by!(user_id: 1, name: "牛串酒場きじま鶴ヶ峰") do |restaurant|
  restaurant.restaurant_genre_id = 3
  restaurant_image = "https://imgfp.hotp.jp/IMGH/05/90/P035030590/P035030590_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P035030590_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001237996/?vos=nhppalsa000016"
  restaurant.address = "神奈川県横浜市旭区鶴ヶ峰1-4-22"
  restaurant.open_time = "月、水～金: 17:00～翌0:00 （料理L.O. 23:00 ドリンクL.O. 23:30）土: 15:00～翌0:00 （料理L.O. 23:00 ドリンクL.O. 23:30）日、祝日: 15:00～22:00 （料理L.O. 21:00 ドリンクL.O. 21:00）"
  restaurant.legular_holiday = "火"
  restaurant.memo = "おいしかった。"
  restaurant.star = 3
end

Restaurant.find_or_create_by!(user_id: 1, name: "オイル焼きイタリアン よだれ") do |restaurant|
  restaurant.restaurant_genre_id = 3
  restaurant_image = "https://imgfp.hotp.jp/IMGH/68/88/P040866888/P040866888_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P040866888_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ003432941/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市天王寺区玉造元町４-１０ 1F"
  restaurant.open_time = "月～日、祝日、祝前日: 17:00～翌0:00 （料理L.O. 23:00 ドリンクL.O. 23:00）"
  restaurant.legular_holiday = "不定休"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 5
end

Restaurant.find_or_create_by!(user_id: 1, name: "39") do |restaurant|
  restaurant.restaurant_genre_id = 3
  restaurant_image = "https://imgfp.hotp.jp/IMGH/63/11/P038456311/P038456311_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P038456311_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001282338/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市北区天神橋５-2-1"
  restaurant.open_time = "月～日、祝日、祝前日: 16:00～翌0:00"
  restaurant.legular_holiday = "なし"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 4
end

Restaurant.find_or_create_by!(user_id: 1, name: "酔処 へべれけ") do |restaurant|
  restaurant.restaurant_genre_id = 4
  restaurant_image = "https://imgfp.hotp.jp/IMGH/00/76/P036280076/P036280076_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P036280076_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001101056/?vos=nhppalsa000016"
  restaurant.address = "栃木県宇都宮市宿郷２-7-3　IRビル宿郷１F"
  restaurant.open_time = "月～日、祝日、祝前日: 19:00～翌5:00 （料理L.O. 翌4:30 ドリンクL.O. 翌4:30）"
  restaurant.legular_holiday = "なし居酒屋をお探しならぜひ【へべれけ】へ♪"
  restaurant.memo = "おいしかった。"
  restaurant.star = 3
end

Restaurant.find_or_create_by!(user_id: 1, name: "牛すじホルモン 二刀流武蔵") do |restaurant|
  restaurant.restaurant_genre_id = 4
  restaurant_image = "https://imgfp.hotp.jp/IMGH/29/40/P042442940/P042442940_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P042442940_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001282429/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市中央区南本町３丁目3-17　丸松ビル2F"
  restaurant.open_time = "月～土、祝前日: 11:30～14:30 （料理L.O. 14:00 ドリンクL.O. 14:00）17:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:30）"
  restaurant.legular_holiday = "日、祝日"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 4
end

Restaurant.find_or_create_by!(user_id: 1, name: "スパイスカレーとコーラ ヤドカリー 天王寺hoop店") do |restaurant|
  restaurant.restaurant_genre_id = 5
  restaurant_image = "https://imgfp.hotp.jp/IMGH/92/11/P041059211/P041059211_238.jpg"
  file = URI.open(restaurant_image)
  file_name = "P041059211_238.jpg"
  restaurant.restaurant_image.attach(io: file, filename: file_name)
  restaurant.url = "https://www.hotpepper.jp/strJ001277384/?vos=nhppalsa000016"
  restaurant.address = "大阪府大阪市阿倍野区阿倍野筋１－２－３０ 地下1Fダイニングコート内"
  restaurant.open_time = "月～日、祝日、祝前日: 11:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:00）"
  restaurant.legular_holiday = "定休日：1/1"
  restaurant.memo = "とてもおいしかった。また行きたい。"
  restaurant.star = 5
end

# お店のお気に入り作成
restaurant_favorites = [
  { user_id: 1, restaurant_id: 1 },
  { user_id: 1, restaurant_id: 3 },
  { user_id: 1, restaurant_id: 5 },
  { user_id: 1, restaurant_id: 7 },
  { user_id: 1, restaurant_id: 8 },
  { user_id: 1, restaurant_id: 10 },
  { user_id: 1, restaurant_id: 11 }
]

restaurant_favorites.each do |restaurant_favorite|
  RestaurantFavorite.find_or_create_by!(restaurant_favorite)
end