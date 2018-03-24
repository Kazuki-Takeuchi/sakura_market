class ShoppingHistoryItem < ApplicationRecord
  belongs_to :shopping_history

  validates_presence_of :shopping_history_id
  validates_presence_of :name
  validates_presence_of :price

  def self.get_params(shopping_cart_item)
    commodity = shopping_cart_item.commodity
    {
      name: commodity.name,
      price: commodity.price
    }
  end
end
