require "rails_helper"

RSpec.describe PropertyAttributesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/property_attributes").to route_to("property_attributes#index")
    end

    it "routes to #show" do
      expect(get: "/property_attributes/1").to route_to("property_attributes#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/property_attributes").to route_to("property_attributes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/property_attributes/1").to route_to("property_attributes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/property_attributes/1").to route_to("property_attributes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/property_attributes/1").to route_to("property_attributes#destroy", id: "1")
    end
  end
end
