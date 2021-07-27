require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'before publication' do
    it 'validates minimum title length must be 6' do
      post = build(:post, title: "n" * 5)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("is too short (minimum is 6 characters)")
    end

    it 'validates maximum title length must be 50' do
      post = build(:post, title: "n" * 51)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("is too long (maximum is 50 characters)")
    end

    it 'validates minimum body length must be 10' do
      post = build(:post, body: "n" * 5)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("is too short (minimum is 10 characters)")
    end

    it 'validates maximum body length must be 500' do
      post = build(:post, body: "n" * 501)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("is too long (maximum is 500 characters)")
    end

    it 'must have category' do
      post = build(:post, category: nil)
      expect(post).to be_invalid
      expect(post.errors[:category]).to include("can't be blank")
    end

    it 'must have creator' do
      post = build(:post, creator: nil)
      expect(post).to be_invalid
      expect(post.errors[:creator]).to include("can't be blank")
    end

    it 'should have body' do
      post = build(:post, body: nil)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("can't be blank")
    end

    it 'should have title' do
      post = build(:post, title: nil)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'should run normally while providing correct data' do
      post = build(:post)
      expect(post).to be_valid
    end
  end
end
