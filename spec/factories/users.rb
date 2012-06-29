FactoryGirl.define do
  factory :user do |f|
    f.name 'Test User Name'
    f.email Faker::Internet.safe_email
    f.identity 'http://google/test_user/asdfasdfasdf'
  end
end
