# == Schema Information
#
# Table name: projects
#
#  id                       :integer          not null, primary key
#  title                    :string(255)      not null
#  logline                  :string(140)      not null
#  description              :text
#  start_date               :date             not null
#  created_at               :datetime
#  updated_at               :datetime
#  cover_image_file_name    :string(255)
#  cover_image_content_type :string(255)
#  cover_image_file_size    :integer
#  cover_image_updated_at   :datetime
#

require 'paperclip'

class Project < ActiveRecord::Base
  
  has_attached_file :cover_image,
  {   
      :path => "#{UPLOAD_BASE_PATH}/images/cover/:hash.:extension",
      :hash_secret => "sahalj=7hklas44hdadfj3qpjf8pda8cl",
      :styles => { medium: '300x300>' }
  }
  
  validates_presence_of :title, :message => "required"
  validates_presence_of :logline, :message => "required"
  validates_presence_of :logline, :message => "required"
  validates_presence_of :start_date, :message => "required"
  validate :valid_title, :valid_logline, :valid_description, :valid_start_date, :valid_image
  
  def skills
  end
  
  def skills=(value)
  end
  
  private
  def valid_title
    title.try(:strip!)
    if title.present? and title.length > 60
      errors[:base] << "Title can be at most 60 characters"
    end
  end
  
  def valid_logline
    logline.try(:strip!)
    if logline.present? and logline.length > 140
      errors[:base] << "Log line can be at most 140 characters"
    end
  end
  
  def valid_description
    description.try(:strip!)
    if description.present? and description.length > 500
      errors[:base] << "Description can be at most 500 characters"
    end
  end
  
  def valid_start_date
    if start_date.present? and start_date < Time.zone.today
      errors[:base] << "Start date must be in the future"
    end
  end
  
  def valid_image
    if cover_image_file_name.blank?
      errors[:base] << "Cover image required"
    end
  end
end
