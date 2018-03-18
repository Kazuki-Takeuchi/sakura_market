class ShoppingCartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :commodity

  validates_presence_of :shopping_cart_id
  validates_presence_of :commodity_id
end
