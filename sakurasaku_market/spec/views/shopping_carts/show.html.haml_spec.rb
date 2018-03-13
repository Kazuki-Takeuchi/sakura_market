require 'rails_helper'

RSpec.describe "shopping_carts/show", type: :view do
  before(:each) do
    @shopping_cart = assign(:shopping_cart, ShoppingCart.create!(
      :user_id => 2,
      :payment_method_type => 3,
      :delivery_period_type => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
