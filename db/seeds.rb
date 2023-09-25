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
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 3
end

# レシピのお気に入り作成
RecipeFavorite.find_or_create_by!(user_id: 1, recipe_id: 1)

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
  restaurant.star = 3
end

# お店のお気に入り作成
RestaurantFavorite.find_or_create_by!(user_id: 1, restaurant_id: 1)