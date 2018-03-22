require 'rails_helper'

RSpec.describe "shopping_histories/index", type: :view do
  before(:each) do
    assign(:shopping_histories, [
      ShoppingHistory.create!(
        :user_id => 2,
        :payment_method_type => 3,
        :delivery_period_type => 4,
        :cash_on_delivery_commission => 5,
        :tax_included_price => 6,
        :subtotal => 7,
        :shipping_fee => 8
      ),
      ShoppingHistory.create!(
        :user_id => 2,
        :payment_method_type => 3,
        :delivery_period_type => 4,
        :cash_on_delivery_commission => 5,
        :tax_included_price => 6,
        :subtotal => 7,
        :shipping_fee => 8
      )
    ])
  end

  it "renders a list of shopping_histories" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
  end
end
