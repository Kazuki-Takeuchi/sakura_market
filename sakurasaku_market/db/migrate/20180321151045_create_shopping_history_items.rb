class CreateShoppingHistoryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_history_items do |t|
      t.string :name
      t.integer :price
      t.integer :shopping_history_id

      t.timestamps
    end
  end
end
