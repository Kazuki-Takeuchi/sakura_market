require 'rails_helper'

RSpec.describe "commodities/show", type: :view do
  before(:each) do
    @commodity = assign(:commodity, Commodity.create!(
      :name => "Name",
      :file_id => "File",
      :price => 2,
      :caption => "MyText",
      :display_flag => false,
      :display_index => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/File/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
  end
end
