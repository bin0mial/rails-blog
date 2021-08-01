require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe "GET /index" do
    it "returns successful response" do
      get "/api/v1/posts"
      expect(response).to have_http_status(:success)
    end
    it "returns all posts" do
      posts = create_list :post, 10
      get "/api/v1/posts"
      expect(response.body).to include PostBlueprint.render(posts, root: :data)
    end
  end

  describe "GET /show" do
    context "when posts not exist" do
      it "should raise error" do
        expect { get api_v1_post_url(1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when posts exist" do
      let(:posts) { create_list(:post, 2) }

      it "returns successful response" do
        get api_v1_post_url(posts.first)
        expect(response).to have_http_status(:success)
      end

      it "returns the right post" do
        get api_v1_post_url(posts.last)
        expect(response.body).to include PostBlueprint.render(posts.last, root: :data)
      end
    end
  end
end
