require 'rails_helper'

RSpec.describe "shopping_histories/new", type: :view do
  before(:each) do
    assign(:shopping_history, ShoppingHistory.new(
      :user_id => 1,
      :payment_method_type => 1,
      :delivery_period_type => 1,
      :cash_on_delivery_commission => 1,
      :tax_included_price => 1,
      :subtotal => 1,
      :shipping_fee => 1
    ))
  end

  it "renders new shopping_history form" do
    render

    assert_select "form[action=?][method=?]", shopping_histories_path, "post" do

      assert_select "input[name=?]", "shopping_history[user_id]"

      assert_select "input[name=?]", "shopping_history[payment_method_type]"

      assert_select "input[name=?]", "shopping_history[delivery_period_type]"

      assert_select "input[name=?]", "shopping_history[cash_on_delivery_commission]"

      assert_select "input[name=?]", "shopping_history[tax_included_price]"

      assert_select "input[name=?]", "shopping_history[subtotal]"

      assert_select "input[name=?]", "shopping_history[shipping_fee]"
    end
  end
end
