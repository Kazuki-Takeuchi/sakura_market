require 'rails_helper'

RSpec.describe "ShoppingHistories", type: :request do
  describe "GET /shopping_histories" do
    it "works! (now write some real specs)" do
      get shopping_histories_path
      expect(response).to have_http_status(200)
    end
  end
end
