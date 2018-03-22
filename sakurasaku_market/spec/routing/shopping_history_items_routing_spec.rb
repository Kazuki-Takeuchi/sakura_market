require "rails_helper"

RSpec.describe ShoppingHistoryItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shopping_history_items").to route_to("shopping_history_items#index")
    end

    it "routes to #new" do
      expect(:get => "/shopping_history_items/new").to route_to("shopping_history_items#new")
    end

    it "routes to #show" do
      expect(:get => "/shopping_history_items/1").to route_to("shopping_history_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shopping_history_items/1/edit").to route_to("shopping_history_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shopping_history_items").to route_to("shopping_history_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shopping_history_items/1").to route_to("shopping_history_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shopping_history_items/1").to route_to("shopping_history_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shopping_history_items/1").to route_to("shopping_history_items#destroy", :id => "1")
    end

  end
end
