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

class Project < ActiveRecord::Base
  
  has_attached_file :cover_image,
    {   
        :path => "#{UPLOAD_BASE_PATH}/images/cover/:hash.:extension",
        :hash_secret => "sahalj=7hklas44hdadfj3qpjf8pda8cl",
        :styles => { medium: '300x300>' }
    }
  
  def skills
  end
  
  def skills=(value)
  end
end
