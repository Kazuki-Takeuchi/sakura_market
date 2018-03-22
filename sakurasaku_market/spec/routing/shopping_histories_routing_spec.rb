require "rails_helper"

RSpec.describe ShoppingHistoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shopping_histories").to route_to("shopping_histories#index")
    end

    it "routes to #new" do
      expect(:get => "/shopping_histories/new").to route_to("shopping_histories#new")
    end

    it "routes to #show" do
      expect(:get => "/shopping_histories/1").to route_to("shopping_histories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shopping_histories/1/edit").to route_to("shopping_histories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shopping_histories").to route_to("shopping_histories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shopping_histories/1").to route_to("shopping_histories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shopping_histories/1").to route_to("shopping_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shopping_histories/1").to route_to("shopping_histories#destroy", :id => "1")
    end

  end
end
