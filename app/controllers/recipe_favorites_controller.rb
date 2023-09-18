class RecipeFavoritesController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    recipe_favorite = current_user.recipe_favorites.new(recipe_id: @recipe.id)
    recipe_favorite.save
  end
  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    recipe_favorite = current_user.recipe_favorites.find_by(recipe_id: @recipe.id)
    recipe_favorite.destroy
  end
  
end
