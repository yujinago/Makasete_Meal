class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.integer :user_id, null: false
      t.integer :restaurant_genre_id, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.string :address, null: false
      t.string :open_time, null: false
      t.string :legular_holiday, null: false
      t.text :memo

      t.timestamps
    end
  end
end
