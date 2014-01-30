# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:imdb) { |n| "http://www.imdb.com" }
    website nil
  end
end
