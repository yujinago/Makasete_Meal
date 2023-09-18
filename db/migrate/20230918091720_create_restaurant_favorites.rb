class CreateRestaurantFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurant_favorites do |t|
      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false

      t.timestamps
    end
  end
end
