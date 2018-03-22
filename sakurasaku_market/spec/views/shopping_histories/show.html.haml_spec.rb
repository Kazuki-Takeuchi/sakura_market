require 'rails_helper'

RSpec.describe "shopping_histories/show", type: :view do
  before(:each) do
    @shopping_history = assign(:shopping_history, ShoppingHistory.create!(
      :user_id => 2,
      :payment_method_type => 3,
      :delivery_period_type => 4,
      :cash_on_delivery_commission => 5,
      :tax_included_price => 6,
      :subtotal => 7,
      :shipping_fee => 8
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
  end
end
