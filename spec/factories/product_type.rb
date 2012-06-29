FactoryGirl.define do
  factory :product_type do
    name Faker::Lorem.words.to_s
  end
end
