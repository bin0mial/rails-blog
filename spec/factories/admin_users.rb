FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.safe_email }
    password { "password" }
  end
end
