require 'rails_helper'

RSpec.describe "shopping_history_items/show", type: :view do
  before(:each) do
    @shopping_history_item = assign(:shopping_history_item, ShoppingHistoryItem.create!(
      :name => "Name",
      :price => "Price",
      :integer => "Integer",
      :shopping_history_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Price/)
    expect(rendered).to match(/Integer/)
    expect(rendered).to match(/2/)
  end
end
