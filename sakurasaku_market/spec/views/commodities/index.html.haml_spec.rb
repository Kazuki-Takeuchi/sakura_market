require 'rails_helper'

RSpec.describe "commodities/index", type: :view do
  before(:each) do
    assign(:commodities, [
      Commodity.create!(
        :name => "Name",
        :file_id => "File",
        :price => 2,
        :caption => "MyText",
        :display_flag => false,
        :display_index => 3
      ),
      Commodity.create!(
        :name => "Name",
        :file_id => "File",
        :price => 2,
        :caption => "MyText",
        :display_flag => false,
        :display_index => 3
      )
    ])
  end

  it "renders a list of commodities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
