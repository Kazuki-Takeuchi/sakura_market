class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_items, dependent: :destroy

  enum payment_method_type: { 代引き: 1 }
  enum delivery_period_type: { "8-12":1, "12-14":2, "14-16":3, "16-18":4, "18-20":5, "20-21":6 }

  def self.get_shopping_cart(user)
    shopping_cart = user.shopping_cart
    if shopping_cart.nil?
      shopping_cart = user.build_shopping_cart
      unless shopping_cart.save
        shopping_cart = nil
      end
    end
    shopping_cart
  end
end
