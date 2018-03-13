require 'rails_helper'

RSpec.describe "shopping_carts/edit", type: :view do
  before(:each) do
    @shopping_cart = assign(:shopping_cart, ShoppingCart.create!(
      :user_id => 1,
      :payment_method_type => 1,
      :delivery_period_type => 1
    ))
  end

  it "renders the edit shopping_cart form" do
    render

    assert_select "form[action=?][method=?]", shopping_cart_path(@shopping_cart), "post" do

      assert_select "input[name=?]", "shopping_cart[user_id]"

      assert_select "input[name=?]", "shopping_cart[payment_method_type]"

      assert_select "input[name=?]", "shopping_cart[delivery_period_type]"
    end
  end
end
