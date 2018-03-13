class CreateShoppingCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_items do |t|
      t.integer :shopping_cart_id
      t.integer :commodity_id

      t.timestamps
    end
  end
end
