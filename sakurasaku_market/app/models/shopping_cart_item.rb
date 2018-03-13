class ShoppingCartItem < ApplicationRecord
  belongs_to :shopping_carts
  has_one :commodity
end
