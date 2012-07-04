# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :work_order do
    association :author, factory: :user, email: Faker::Internet.email
    association :owner, factory: :user, email: Faker::Internet.email
    association :client
    association :payment_type
  end
end
