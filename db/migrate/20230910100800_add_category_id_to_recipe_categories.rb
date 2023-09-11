class AddCategoryIdToRecipeCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_categories, :category_id, :string
  end
end
