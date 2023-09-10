class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe_categories = RecipeCategory.all
  end

  def confirm
    @recipe_categories = RecipeCategory.all
    random_num = rand(1..4)
    results = []
    if params[:recipe][:select_recipe_category_id] == "0"
      RakutenWebService::Recipe.ranking(params[:recipe][:recipe_category_id]).each {|n| results << n}
      result = results.select {|n| n.rank == random_num}
      result = results.first
      result_hash = {
        user_id: current_user.id,
        recipe_category_id: params[:recipe][:recipe_category_id],
        name: result["recipeTitle"],
        url: result["recipeUrl"],
        poster_name: result["nickname"],
        cook_time: result["recipeIndication"],
        cost: result["recipeCost"],
        foodstuff_name: result["recipeMaterial"],
      }
      @recipe_image = result["foodImageUrl"]
      @recipe = Recipe.new(result_hash)
    elsif params[:recipe][:select_recipe_category_id] == "1"
      recipe_category_id = @recipe_categories.offset( rand(@recipe_categories.count) ).first.id
      RakutenWebService::Recipe.ranking(params[:recipe][:recipe_category_id]).each {|n| results << n}
      result = results.select {|n| n.rank == random_num}
      result = results.first
      result_hash = {
        user_id: current_user.id,
        recipe_category_id: recipe_category_id,
        name: result["recipeTitle"],
        url: result["recipeUrl"],
        poster_name: result["nickname"],
        cook_time: result["recipeIndication"],
        cost: result["recipeCost"],
        foodstuff_name: result["recipeMaterial"]
      }
      @recipe_image = result["foodImageUrl"]
      @recipe = Recipe.new(result_hash)
    end
    
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    require 'open-uri'
    recipe_image = params[:recipe][:recipe_image]
    file = URI.open(recipe_image)
    file_name = File.basename(URI.parse(recipe_image).path)
    @recipe.recipe_image.attach(io: file, filename: file_name)
    @recipe.save
    redirect_to complete_recipes_path
  end
  
  def complete
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :url, :recipe_category_id, :poster_name, :cook_time, :cost, :foodstuff_name)
  end
  
end
