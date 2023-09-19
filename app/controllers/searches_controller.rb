class SearchesController < ApplicationController
  def search
    @recipe_categories = RecipeCategory.all
    @restaurant_genres = RestaurantGenre.all
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "Recipe"
      results = Recipe.looks(@search, @word, current_user.id)
    else
      results = Restaurant.looks(@search, @word, current_user.id)
    end
    
    results = results.latest if params[:latest]
    results = results.old if params[:old]
    results = results.star_count if params[:star_count]
    
    @results = results.page(params[:page])
    
    # recipes = params[:latest] ? recipes.latest : recipes
    # recipes = params[:old] ? recipes.old : recipes
    # recipes = params[:star_count] ? recipes.star_count : recipes
    
    # @recipes = recipes.page(params[:page])
    
    # restaurants = params[:latest] ? restaurants.latest : restaurants
    # restaurants = params[:old] ? restaurants.old : restaurants
    # restaurants = params[:star_count] ? restaurants.star_count : restaurants
    
    # @restaurants = restaurants.page(params[:page])
    if @range == "Recipe"
      search_text_mapping = {
        "name" => "レシピ名",
        "poster_name" => "投稿者名",
        "cook_time" => "調理時間",
        "cost" => "費用",
        "foodstuff_name" => "材料名",
      }
    else
      search_text_mapping = {
        "name" => "店名",
        "address" => "住所",
        "open_time" => "営業時間",
        "legular_holiday" => "定休日",
      }
    end
    
    @search_text = search_text_mapping[@search]
    
  end
end
