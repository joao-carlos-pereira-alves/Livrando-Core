require "rails_helper"

RSpec.describe BookCategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/book_categories").to route_to("book_categories#index")
    end

    it "routes to #show" do
      expect(get: "/book_categories/1").to route_to("book_categories#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/book_categories").to route_to("book_categories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/book_categories/1").to route_to("book_categories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/book_categories/1").to route_to("book_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/book_categories/1").to route_to("book_categories#destroy", id: "1")
    end
  end
end
