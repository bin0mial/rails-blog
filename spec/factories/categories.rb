FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.category }
  end
end