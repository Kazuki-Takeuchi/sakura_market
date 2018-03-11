require "rails_helper"

RSpec.describe CommoditiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/commodities").to route_to("commodities#index")
    end

    it "routes to #new" do
      expect(:get => "/commodities/new").to route_to("commodities#new")
    end

    it "routes to #show" do
      expect(:get => "/commodities/1").to route_to("commodities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/commodities/1/edit").to route_to("commodities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/commodities").to route_to("commodities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/commodities/1").to route_to("commodities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/commodities/1").to route_to("commodities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/commodities/1").to route_to("commodities#destroy", :id => "1")
    end

  end
end
