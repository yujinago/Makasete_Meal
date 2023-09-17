class AddStarToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :star, :integer, null: false, default: 0
  end
end
