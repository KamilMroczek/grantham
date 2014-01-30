# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :signup do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:imdb) { |n| "http://www.imdb.com/name/#{n}" }
    website nil
    approved false
  end
end
