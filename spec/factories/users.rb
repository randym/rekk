FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.identity 'http://google/test_user/asdfasdfasdf'
  end
end
