class SearchesController < ApplicationController
  def search
    @recipe_categories = RecipeCategory.all
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "Recipe"
      recipes = Recipe.looks(@search, @word, current_user.id)
    else
      @restaurants = current_user.restaurants.looks(@search, @word)
    end
    
    recipes = params[:latest] ? recipes.latest : recipes
    recipes = params[:old] ? recipes.old : recipes
    recipes = params[:star_count] ? recipes.star_count : recipes
    
    @recipes = recipes.page(params[:page])
    
    search_text_mapping = {
      "name" => "レシピ名",
      "poster_name" => "投稿者名",
      "cook_time" => "調理時間",
      "cost" => "費用",
      "foodstuff_name" => "材料名",
    }
    @search_text = search_text_mapping[@search]
    
  end
end
