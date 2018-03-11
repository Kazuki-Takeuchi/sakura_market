require 'rails_helper'

RSpec.describe "commodities/edit", type: :view do
  before(:each) do
    @commodity = assign(:commodity, Commodity.create!(
      :name => "MyString",
      :file_id => "MyString",
      :price => 1,
      :caption => "MyText",
      :display_flag => false,
      :display_index => 1
    ))
  end

  it "renders the edit commodity form" do
    render

    assert_select "form[action=?][method=?]", commodity_path(@commodity), "post" do

      assert_select "input[name=?]", "commodity[name]"

      assert_select "input[name=?]", "commodity[file_id]"

      assert_select "input[name=?]", "commodity[price]"

      assert_select "textarea[name=?]", "commodity[caption]"

      assert_select "input[name=?]", "commodity[display_flag]"

      assert_select "input[name=?]", "commodity[display_index]"
    end
  end
end
