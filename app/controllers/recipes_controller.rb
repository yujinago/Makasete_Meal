class RecipesController < ApplicationController
  before_action :ensure_current_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @recipe = Recipe.new
    @recipe_categories = RecipeCategory.all
  end

  def confirm
    @recipe_categories = RecipeCategory.all
    results = []
    if params[:recipe][:select_recipe_category_id] == "0"
      category_id = params[:recipe][:recipe_category_id]
    elsif params[:recipe][:select_recipe_category_id] == "1"
      category_id = @recipe_categories.offset( rand(@recipe_categories.count) ).first.category_id
    end
    if category_id.blank?
      redirect_to new_recipe_path, notice: "カテゴリーを選択するか、完全におまかせを選択してください。"
    else
      recipe_category = RecipeCategory.find_by(category_id: category_id)
      RakutenWebService::Recipe.ranking(category_id).each {|n| results << n}
      result = results.sample
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
    @recipe_categories = RecipeCategory.all
    if params[:category_id]
      @recipe_category = RecipeCategory.find(params[:category_id])
      @category_recipe_all = @recipe_category.recipes.where(user_id: current_user.id)
      @recipes = @recipe_category.recipes.where(user_id: current_user.id).page(params[:page])
    else
      if params[:latest]
        @recipes = current_user.recipes.latest.page(params[:page])
      elsif params[:old]
        @recipes = current_user.recipes.old.page(params[:page])
      elsif params[:star_count]
        @recipes = current_user.recipes.star_count.page(params[:page])
      else
        @recipes = current_user.recipes.page(params[:page])
      end
      @recipe_all = current_user.recipes.all
    end
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end
  
  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update(recipe_review_params)
      flash[:notice] = "レシピのレビューを変更しました"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end
  
  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :url, :recipe_category_id, :poster_name, :cook_time, :cost, :foodstuff_name)
  end
  
  def recipe_review_params
    params.require(:recipe).permit(:memo, :star)
  end
  
  def ensure_current_user
    if params[:id] == "confirm"
      flash[:alert] = "提案画面でのリロードは無効です。もう一度条件を選択し直してください。"
      redirect_to new_recipe_path
    else
      recipe = Recipe.find_by(id: params[:id])
      if recipe.nil? || current_user.id != recipe.user_id
        flash[:alert] = "不正なアクセスです。"
        redirect_to recipes_path
      end
    end
  end
  
end
