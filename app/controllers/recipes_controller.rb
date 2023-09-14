class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe_categories = RecipeCategory.all
  end

  def confirm
    @recipe_categories = RecipeCategory.all
    # random_num = rand(1..4)
    results = []
    if params[:recipe][:select_recipe_category_id] == "0"
      category_id = params[:recipe][:recipe_category_id]
    elsif params[:recipe][:select_recipe_category_id] == "1"
      category_id = @recipe_categories.offset( rand(@recipe_categories.count) ).first.category_id
    end
    if category_id.blank?
      # flash.now[:notice] = "カテゴリーを選択するか、完全におまかせを選択してください。"
      redirect_to new_recipe_path, notice: "カテゴリーを選択するか、完全におまかせを選択してください。"
    else
      recipe_category = RecipeCategory.find_by(category_id: category_id)
      RakutenWebService::Recipe.ranking(category_id).each {|n| results << n}
      result = results.sample
      # result = results.select {|n| n.rank == random_num}
      # result = results.first
      result_hash = {
        user_id: current_user.id,
        recipe_category_id: recipe_category.id,
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
    
    # if @recipe.recipe_category_id.blank?
    #   flash.now[:notice] = "カテゴリーを選択するか、完全におまかせを選択してください。"
    #   render :new
    # end
    
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    require 'open-uri'
    recipe_image = params[:recipe][:recipe_image]
    file = URI.open(recipe_image)
    file_name = File.basename(URI.parse(recipe_image).path)
    @recipe.recipe_image.attach(io: file, filename: file_name)
    @recipe.save
    session[:last_saved_info] = @recipe
    redirect_to complete_recipes_path
  end
  
  def complete
    @recipe = session[:last_saved_info]
    @recipe_category = RecipeCategory.find_by(id: @recipe['recipe_category_id'])
    @recipe_info = Recipe.find_by(foodstuff_name: @recipe['foodstuff_name'])
    @foodstuff_name_format = @recipe_info.foodstuff_name_format
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_memo_params)
      flash.now[:notice] = "レシピのレビューを変更しました"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :url, :recipe_category_id, :poster_name, :cook_time, :cost, :foodstuff_name)
  end
  
  def recipe_memo_params
    params.require(:recipe).permit(:memo)
  end
  
end
