class AddStarToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :star, :integer, null: false, default: 0
  end
end
