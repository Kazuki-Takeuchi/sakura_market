class CreateShoppingHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_histories do |t|
      t.integer :user_id
      t.string :address
      t.integer :payment_method_type
      t.datetime :delivery_date
      t.integer :delivery_period_type
      t.integer :cash_on_delivery_commission
      t.integer :tax_included_price
      t.integer :subtotal
      t.integer :shipping_fee

      t.timestamps
    end
  end
end
