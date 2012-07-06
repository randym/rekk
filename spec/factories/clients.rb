FactoryGirl.define do
  factory :client do 
    name { Faker::Company.name }
    user { |u| u.association(:user, email: Faker::Internet.email) }
  end

  factory :complete_client, class: Client do
    name { Faker::Company.name }
    user { |u| u.association(:user, email: Faker::Internet.email) }
    local_name { Faker::Lorem.words(3).join(' ') }
    memo { Faker::Lorem.words(50).join(' ') }
    accounting_code { Faker::Lorem.words(1).to_s }

  end
end
