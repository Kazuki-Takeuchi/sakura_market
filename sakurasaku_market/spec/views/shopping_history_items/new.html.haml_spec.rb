require 'rails_helper'

RSpec.describe "shopping_history_items/new", type: :view do
  before(:each) do
    assign(:shopping_history_item, ShoppingHistoryItem.new(
      :name => "MyString",
      :price => "MyString",
      :integer => "MyString",
      :shopping_history_id => 1
    ))
  end

  it "renders new shopping_history_item form" do
    render

    assert_select "form[action=?][method=?]", shopping_history_items_path, "post" do

      assert_select "input[name=?]", "shopping_history_item[name]"

      assert_select "input[name=?]", "shopping_history_item[price]"

      assert_select "input[name=?]", "shopping_history_item[integer]"

      assert_select "input[name=?]", "shopping_history_item[shopping_history_id]"
    end
  end
end
