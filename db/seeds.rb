require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by!(email: "taro@example.com") do |user|
  user.nickname = "たろう"
  user.password = "testtaro"
end

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
  recipe.foodstuff_name = "[\"もやし\", \"卵\", \"塩胡椒\", \"おたふくソース（お好み焼きソース）\", \"マヨネーズ\", \"お好きなトッピング(葱･鰹節･青のり等)\"]"
  recipe.memo = "とてもおいしかった。また作る。"
  recipe.star = 3
end

RecipeFavorite.find_or_create_by!(user_id: 1, recipe_id: 1)