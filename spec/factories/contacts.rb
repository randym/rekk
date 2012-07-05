FactoryGirl.define do
  factory :contact do |f|
    f.name Faker::Name.name
    f.email { Faker::Internet.email }
    f.association :client
  end
end
