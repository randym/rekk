FactoryGirl.define do
  factory :billing_address do |f|
    f.postal_code { Faker::Address::zip_code }
    f.company_name { Faker::Company.name }
    f.association :client
  end
  factory :complete_billing_address, class: BillingAddress do |f|
    f.postal_code { Faker::Address::zip_code }
    f.address_1 { Faker::Address::city }
    f.address_2 { Faker::Address::secondary_address }
    f.address_3 { Faker::Address::street_address }
    f.company_name { Faker::Company.name }
    f.recipient_name { Faker::Name.name }
    f.recipient_title { Faker::Company.bs }
    f.association :client
  end
end
