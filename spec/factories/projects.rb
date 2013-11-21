# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "Title A"
    logline "Loglines are short."
    description "This is a description of a project."
    start_date Time.zone.today
    cover_image_file_name "image.jpg"
    cover_image_content_type "jpg"
    cover_image_file_size 128
    cover_image_updated_at Time.current
  end
end
