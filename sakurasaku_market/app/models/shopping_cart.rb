class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_items, dependent: :destroy
  validate :check_delivery_date

  enum payment_method_type: { 代引き: 1 }
  enum delivery_period_type: { "8-12":1, "12-14":2, "14-16":3, "16-18":4, "18-20":5, "20-21":6 }

  # 代引き手数料 {上限,手数料}
  @@cash_on_delivery_commission_table = { 10000 => 300, 30000 => 400, 100000 => 600, MAX: 1000 }
  @@unit_shipping_fee = 600
  @@unit_shipping_fee_count = 5
  @@consumption_tax = 0.08

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
      errors.add(:delivery_date, "は 3営業日（営業日: 月-金）から14営業日までです。")
    end
  end

  def get_delivery_date_list
    (0..30).map {|i|
      (Date.today+i).next_day
    }.select {|date|
        date.wday != 0 && date.wday != 6
      }.slice(2,13)
  end

  def self.get_cash_on_delivery_commission(subtotal)
    if subtotal == 0
      return 0
    end
    @@cash_on_delivery_commission_table.keys.each {|border|
      if border == :MAX
        return @@cash_on_delivery_commission_table[:MAX]
      elsif border > subtotal
        return @@cash_on_delivery_commission_table[border]
      end
    }
  end

  def self.get_tax_included_price(price)
    (price * (1 + @@consumption_tax)).floor
  end

  def get_shopping_cart_items_subtotal
    self.shopping_cart_items.map{|item| item.commodity.price}.sum
  end

  def get_shipping_fee
    ((self.shopping_cart_items.count + @@unit_shipping_fee_count - 1) / @@unit_shipping_fee_count) * @@unit_shipping_fee
  end
end
