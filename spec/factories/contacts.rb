FactoryGirl.define do
  factory :contact do |f|
    f.name Faker::Name.name
    f.email { Faker::Internet.email }
    f.association :client
  end
  factory :complete_contact, class: Contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    job_title { Faker::Company.catch_phrase }
    phone { Faker::PhoneNumber.phone_number }
    division { Faker::Company.bs }
    association :client
  end
end
