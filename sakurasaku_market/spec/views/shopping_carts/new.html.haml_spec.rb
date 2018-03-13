require 'rails_helper'

RSpec.describe "shopping_carts/new", type: :view do
  before(:each) do
    assign(:shopping_cart, ShoppingCart.new(
      :user_id => 1,
      :payment_method_type => 1,
      :delivery_period_type => 1
    ))
  end

  it "renders new shopping_cart form" do
    render

    assert_select "form[action=?][method=?]", shopping_carts_path, "post" do

      assert_select "input[name=?]", "shopping_cart[user_id]"

      assert_select "input[name=?]", "shopping_cart[payment_method_type]"

      assert_select "input[name=?]", "shopping_cart[delivery_period_type]"
    end
  end
end
