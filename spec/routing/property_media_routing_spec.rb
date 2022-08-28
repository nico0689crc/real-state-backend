require "rails_helper"

RSpec.describe PropertyMediaController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/property_media").to route_to("property_media#index")
    end

    it "routes to #show" do
      expect(get: "/property_media/1").to route_to("property_media#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/property_media").to route_to("property_media#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/property_media/1").to route_to("property_media#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/property_media/1").to route_to("property_media#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/property_media/1").to route_to("property_media#destroy", id: "1")
    end
  end
end
