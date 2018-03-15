class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_items, dependent: :destroy
  validate :check_delivery_date

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

  def check_delivery_date
    unless self.get_delivery_date_list.include?(self.delivery_date.to_date)
      errors.add(:delivery_date, "は 3営業日（営業日: 月-金）から14営業日までです。")    end
  end

  def get_delivery_date_list
    (0..30).map {|i|
      (Date.today+i).next_day
    }.select {|date|
        date.wday != 0 && date.wday != 6
      }.slice(2,13)
  end
end
