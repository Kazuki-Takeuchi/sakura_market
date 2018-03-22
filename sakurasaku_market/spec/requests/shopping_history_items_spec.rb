require 'rails_helper'

RSpec.describe "ShoppingHistoryItems", type: :request do
  describe "GET /shopping_history_items" do
    it "works! (now write some real specs)" do
      get shopping_history_items_path
      expect(response).to have_http_status(200)
    end
  end
end
