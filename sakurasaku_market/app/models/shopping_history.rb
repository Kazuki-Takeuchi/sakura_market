class ShoppingHistory < ApplicationRecord
  belongs_to :user
  has_many :shopping_history_items, dependent: :destroy

  enum payment_method_type: { 代引き: 1 }
  enum delivery_period_type: { "8-12":1, "12-14":2, "14-16":3, "16-18":4, "18-20":5, "20-21":6 }

  def self.get_params(shopping_cart)
    subtotal = shopping_cart.get_shopping_cart_items_subtotal
    cash_on_delivery_commission = ShoppingCart.get_cash_on_delivery_commission(subtotal)
    shipping_fee = shopping_cart.get_shipping_fee

    {
      address: shopping_cart.user.address,
      payment_method_type: shopping_cart.payment_method_type,
      delivery_date: shopping_cart.delivery_date,
      delivery_period_type: shopping_cart.delivery_period_type,
      subtotal: subtotal,
      cash_on_delivery_commission: cash_on_delivery_commission,
      shipping_fee: shipping_fee,
      tax_included_price: ShoppingCart.get_tax_included_price(subtotal + cash_on_delivery_commission + shipping_fee)
    }
  end

  def save_include_items_delete_cart(shopping_cart)
    ShoppingHistory.transaction do
      result = self.save!
      shopping_cart.shopping_cart_items.each do |item|
        history_item = self.shopping_history_items.build(ShoppingHistoryItem.get_params(item))
        history_item.save!
      end
      shopping_cart.destroy!
      true
    end
  rescue
    false  
  end
end
