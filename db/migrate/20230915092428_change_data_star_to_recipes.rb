class ChangeDataStarToRecipes < ActiveRecord::Migration[6.1]
  def change
    change_column :recipes, :star, :integer
  end
end
