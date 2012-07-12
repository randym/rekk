# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :work_order do
    association :author, factory: :user
    association :owner, factory: :user
    association :client
  end
end
