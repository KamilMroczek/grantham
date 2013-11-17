# == Schema Information
#
# Table name: projects
#
#  id                       :integer          not null, primary key
#  title                    :string(255)      not null
#  logline                  :string(140)      not null
#  description              :text
#  start_date               :date
#  created_at               :datetime
#  updated_at               :datetime
#  cover_image_file_name    :string(255)
#  cover_image_content_type :string(255)
#  cover_image_file_size    :integer
#  cover_image_updated_at   :datetime
#

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
