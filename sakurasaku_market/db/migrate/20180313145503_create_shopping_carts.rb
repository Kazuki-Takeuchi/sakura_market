class CreateShoppingCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id
      t.integer :payment_method_type
      t.datetime :delivery_date
      t.integer :delivery_period_type

      t.timestamps
    end
  end
end
