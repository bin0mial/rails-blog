require 'rails_helper'

RSpec.describe "/posts", type: :request do
  let(:category) { create(:category) }
  let(:valid_attributes) { attributes_for :post, category_id: category.id }
  let(:invalid_attributes) { attributes_for :post, title: nil }

  describe "POST /create" do
    context "when not logged" do
      it "redirect to login page" do
        post posts_url, :params => { :post => valid_attributes }
        expect(response).to redirect_to(new_user_session_url)
      end
      it "doesn't create the post" do
        post posts_url, :params => { :post => valid_attributes }
        expect(Post.last).to be(nil)
      end
    end

    context "when user logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "with valid attributes" do
        it "create the post" do
          post posts_url, :params => { :post => valid_attributes }
          expect(Post.last.attributes).to include(valid_attributes.stringify_keys)
        end
        it "redirect to post page" do
          post posts_url, :params => { :post => valid_attributes }
          expect(response).to redirect_to(post_url(Post.last))
        end
      end

      context "with invalid attributes" do
        it "shouldn't create post" do
          post posts_url, :params => { :post => invalid_attributes }
          expect(Post.last).to be(nil)
        end
      end

      it "renders the validation errors" do
        post posts_url, :params => { :post => invalid_attributes }
        expect(response.body).to include(CGI.escape_html(I18n.t("errors.messages.blank")))
      end
    end

  end

  describe "PATCH /update" do
    context "when not logged" do
      it "redirect to login page" do
        post = create(:post)
        patch post_url(post), params: { post: valid_attributes }
        expect(response).to redirect_to(new_user_session_url)
      end
      it "doesn't update the post" do
        post = create(:post)
        patch post_url(post), params: { post: valid_attributes }
        expect(post.attributes).to eq(Post.find(post.id).attributes)
      end
    end

    context "when logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "when not authorized" do
        it "raise unauthorized error" do
          post = create(:post)
          expect { patch post_url(post), params: { post: valid_attributes } }.to raise_error(Pundit::NotAuthorizedError)
        end
        it "doesn't update the post" do
          post = create(:post)
          expect { patch post_url(post), params: { post: valid_attributes } }.to raise_error(Pundit::NotAuthorizedError)
          expect(post.attributes).to_not include(valid_attributes.stringify_keys)
        end
      end

      context "when the post is not found" do
        it "renders 404" do
          post_id = 1
          expect { patch post_url(post_id), params: { post: valid_attributes } }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context "with valid attributes" do
        it "updates the post" do
          post = create(:post, creator: current_user)
          patch post_url(post), params: { post: valid_attributes }
          expect(Post.find(post.id).attributes).to include(valid_attributes.stringify_keys)
        end
        it "redirects to the post page" do
          post = create(:post, creator: current_user)
          patch post_url(post), params: { post: valid_attributes }
          expect(response).to redirect_to(post_url(post))
        end
      end

      context "with invalid attributes" do
        it "doesn't updates the post" do
          post = create(:post, creator: current_user)
          patch post_url(post), params: { post: invalid_attributes }
          expect(Post.find(post.id).attributes).to_not include(valid_attributes.stringify_keys)
        end
        it "renders the validation errors" do
          post = create(:post, creator: current_user)
          patch post_url(post), params: { post: invalid_attributes }
          expect(response.body).to include(CGI.escape_html(I18n.t("errors.messages.blank")))
        end
      end
    end
  end
end