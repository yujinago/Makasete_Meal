class ChangeColumnToRecips < ActiveRecord::Migration[6.1]
  def change
    change_column :recipes, :memo, :text, null: true, default: nil
  end
end
