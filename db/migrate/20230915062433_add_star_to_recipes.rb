class AddStarToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :star, :float, null: false, default: 0
  end
end
