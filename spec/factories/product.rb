FactoryGirl.define do
  factory :product do
    name { Faker::Lorem.words.to_s }
    price 40000
  end
end
