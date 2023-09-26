class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.integer :recipe_category_id, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.string :poster_name, null: false
      t.string :cook_time, null: false
      t.string :cost, null: false
      t.text :foodstuff_name, null: false
      t.text :memo

      t.timestamps
    end
  end
end
