require "rails_helper"

RSpec.describe FavoriteBooksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/favorite_books").to route_to("favorite_books#index")
    end

    it "routes to #show" do
      expect(get: "/favorite_books/1").to route_to("favorite_books#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/favorite_books").to route_to("favorite_books#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/favorite_books/1").to route_to("favorite_books#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/favorite_books/1").to route_to("favorite_books#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/favorite_books/1").to route_to("favorite_books#destroy", id: "1")
    end
  end
end
