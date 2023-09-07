class CreateRestaurantGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurant_genres do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
