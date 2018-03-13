require 'rails_helper'

RSpec.describe "shopping_carts/index", type: :view do
  before(:each) do
    assign(:shopping_carts, [
      ShoppingCart.create!(
        :user_id => 2,
        :payment_method_type => 3,
        :delivery_period_type => 4
      ),
      ShoppingCart.create!(
        :user_id => 2,
        :payment_method_type => 3,
        :delivery_period_type => 4
      )
    ])
  end

  it "renders a list of shopping_carts" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
