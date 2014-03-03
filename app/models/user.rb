# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(256)      not null
#  imdb       :string(256)
#  website    :string(256)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  
  validates_uniqueness_of :email
  validates_presence_of :email
  validate :has_link?
  
  has_many :skill, :through => :user_skill
  has_many :user_skill
  
  private
  def has_link?
    if imdb.blank? && website.blank?
      errors.add(:base, 'needs at least an IMDB link or website link.')
    end
  end
    
end
