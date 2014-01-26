# == Schema Information
#
# Table name: signups
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  imdb       :string(128)
#  linkedin   :string(128)
#  photo      :string(256)
#  approved   :boolean          default(FALSE)
#  complete   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Signup < ActiveRecord::Base

  validate :validate_email
  validate :validate_links
  validates_uniqueness_of :email

  private
  def validate_email
    self.email.try(:strip!)
    self.email.try(:downcase!)
    
    if self.email.blank?
      errors.add(:base, "Please fill in your email")
    elsif !(self.email =~ /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]+/)
      errors.add(:base, "Did you typo your email?")
    end
  end
  
  def validate_links
    self.linkedin.try(:strip!)
    self.imdb.try(:strip!)
    
    if self.linkedin.blank? && self.imdb.blank?
      errors.add(:base, "Specify an IMDB or LinkedIn link so we know who you are!")
    end
    
    validate_linkedin
    validate_imdb
  end
  
  def validate_linkedin
    if self.linkedin.present?
      self.linkedin = cleanup_url(self.linkedin)
      unless self.linkedin =~ /http:\/\/www\.linkedin/
        errors.add(:base, "LinkedIn links should be of the form http://www.linkedin.com")
      end
    end
  end
  
  def validate_imdb
    if self.imdb.present?
      self.imdb = cleanup_url(self.imdb)
      unless self.imdb =~ /http:\/\/www\.imdb/
        errors.add(:base, "IMDB links should be of the form http://www.imdb.com")
      end
    end
  end
  
  def cleanup_url(url)
    url.downcase!
    if url.starts_with?('www')
      url = 'http://' + url
    end
    if url.starts_with?('https')
      url.sub!(/https/, 'http')
    end
    
    url
  end
  
end
