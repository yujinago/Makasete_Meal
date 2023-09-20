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
    
    # 順番指定した際のresults
    results = results.latest if params[:latest]
    results = results.old if params[:old]
    results = results.star_count if params[:star_count]
    
    @results = results.page(params[:page])
    @result_all = results.all

    # 検索時の題名用
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
