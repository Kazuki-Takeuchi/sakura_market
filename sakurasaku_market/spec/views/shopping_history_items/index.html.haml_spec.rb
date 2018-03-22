require 'rails_helper'

RSpec.describe "shopping_history_items/index", type: :view do
  before(:each) do
    assign(:shopping_history_items, [
      ShoppingHistoryItem.create!(
        :name => "Name",
        :price => "Price",
        :integer => "Integer",
        :shopping_history_id => 2
      ),
      ShoppingHistoryItem.create!(
        :name => "Name",
        :price => "Price",
        :integer => "Integer",
        :shopping_history_id => 2
      )
    ])
  end

  it "renders a list of shopping_history_items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
    assert_select "tr>td", :text => "Integer".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
