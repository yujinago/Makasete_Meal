class ChangeColumnToRestaurants < ActiveRecord::Migration[6.1]
  def change
    change_column :restaurants, :memo, :text, null: true, default: nil
  end
end
