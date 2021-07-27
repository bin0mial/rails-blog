FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters[0, 30] }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    category
    association :creator, factory: :user
  end
end
