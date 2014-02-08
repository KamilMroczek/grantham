# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "Title A"
    logline "Loglines are short."
    start_date Time.zone.today
    approved false
  end
end
