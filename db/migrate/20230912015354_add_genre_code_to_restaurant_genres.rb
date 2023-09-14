class AddGenreCodeToRestaurantGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurant_genres, :genre_code, :string, null: false
  end
end
