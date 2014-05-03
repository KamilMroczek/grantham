# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(50)       not null
#  logline    :string(300)      not null
#  start_date :date             not null
#  approved   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  
  has_many :jobs
  has_many :skills, :through => :jobs
  
  accepts_nested_attributes_for :jobs
  
  validates_presence_of :title, :message => 'required'
  validates_presence_of :logline, :message => 'required'
  validates :title, length: { maximum: 50, wrong_length: "Title can be at most %{count} characters" }
  validates :logline, length: { maximum: 300, wrong_length: "Logline can be at most %{count} characters" }
  
  validate :valid_start_date
  validate :valid_jobs
  
  scope :unapproved, -> { where(:approved => false) }
  
  private
  def valid_start_date
    if start_date.nil?
      errors[:base] << "Must select a start date"
      return
    end
    
    if start_date_changed?
      if start_date < Time.zone.today
        errors[:base] << "Start date must be in the future"
      end
    end
  end
  
  def valid_jobs
    if jobs.size == 0
      errors[:base] << "Must specify at least one position"
    end
  end
end
