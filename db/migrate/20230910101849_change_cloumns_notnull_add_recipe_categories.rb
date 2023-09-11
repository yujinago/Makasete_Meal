class ChangeCloumnsNotnullAddRecipeCategories < ActiveRecord::Migration[6.1]
  def change
    change_column :recipe_categories, :category_id, :string, null: false
  end
end
