FactoryGirl.define do
  factory :client do 
    name { Faker::Company.name }
    user { |u| u.association(:user, email: Faker::Internet.email) }
  end
end
