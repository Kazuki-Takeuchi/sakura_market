class ShoppingHistoryItem < ApplicationRecord
  belongs_to :shopping_history

  validates_presence_of :shopping_history_id

  def self.get_params(shopping_cart_item)
    commodity = shopping_cart_item.commodity
    {
      name: commodity.name,
      price: commodity.price
    }
  end
end
