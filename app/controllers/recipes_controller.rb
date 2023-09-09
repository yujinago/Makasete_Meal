class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe_categories = RecipeCategory.all
  end
  
  def create
  end

  def confirm
    @recipe = Recipe.new
    
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
    params.require(:recipe).permit(:recipe_category_id)
  end
end
