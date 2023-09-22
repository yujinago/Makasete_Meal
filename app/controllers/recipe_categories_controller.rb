class RecipeCategoriesController < ApplicationController
  
  def create
    # recipeのnewに遷移する前に新しいカテゴリーがあれば保存
    recipe_categories = []
    results = RakutenWebService::Recipe.large_categories
    results.each do |result|
      recipe_category = RecipeCategory.new(cook(result))
      recipe_categories << recipe_category
    end
    
    recipe_categories.each do |recipe_category|
      unless RecipeCategory.exists?(category_id: recipe_category.category_id)
        recipe_category.save
      end
    end
    
    redirect_to new_recipe_path
  end
  
  private
  
  def cook(result)
    name = result["categoryName"]
    category_id = result["categoryId"]
    {
      name: name,
      category_id: category_id
    }
  end

end
