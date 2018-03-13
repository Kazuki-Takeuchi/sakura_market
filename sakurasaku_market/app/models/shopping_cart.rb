class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_items, dependent: :destroy

  enum payment_method_type: { 代引き: 1 }
  enum delivery_period_type: { "8-12":1, "12-14":2, "14-16":3, "16-18":4, "18-20":5, "20-21":6 }
end
