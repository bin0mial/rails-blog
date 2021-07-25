require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before publication' do
    include_examples "authenticatable", 'user'

    it "validates creation using email and password only" do
      user = User.new :email => Faker::Internet.email, :password => "password"
      expect(user).to be_valid
    end
  end
end
