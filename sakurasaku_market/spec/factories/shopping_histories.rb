FactoryBot.define do
  factory :shopping_history do
    user_id 1
    payment_method_type 1
    delivery_date "2018-03-22 00:09:13"
    delivery_period_type 1
    cash_on_delivery_commission 1
    tax_included_price 1
    subtotal 1
    shipping_fee 1
  end
end
