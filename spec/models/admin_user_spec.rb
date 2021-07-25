require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  context 'before publication' do
    include_examples "authenticatable", 'admin_user'

    it "validates creation using email and password only" do
      admin_user = AdminUser.new :email => Faker::Internet.email, :password => "password"
      expect(admin_user).to be_valid
    end
  end
end
