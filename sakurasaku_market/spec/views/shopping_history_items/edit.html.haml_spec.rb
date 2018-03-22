require 'rails_helper'

RSpec.describe "shopping_history_items/edit", type: :view do
  before(:each) do
    @shopping_history_item = assign(:shopping_history_item, ShoppingHistoryItem.create!(
      :name => "MyString",
      :price => "MyString",
      :integer => "MyString",
      :shopping_history_id => 1
    ))
  end

  it "renders the edit shopping_history_item form" do
    render

    assert_select "form[action=?][method=?]", shopping_history_item_path(@shopping_history_item), "post" do

      assert_select "input[name=?]", "shopping_history_item[name]"

      assert_select "input[name=?]", "shopping_history_item[price]"

      assert_select "input[name=?]", "shopping_history_item[integer]"

      assert_select "input[name=?]", "shopping_history_item[shopping_history_id]"
    end
  end
end
