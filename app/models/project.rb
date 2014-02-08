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
  
  validates_presence_of :title, :message => 'required'
  validates_presence_of :logline, :message => 'required'
  validates :title, length: { maximum: 50, wrong_length: "Title can be at most %{count} characters" }
  validates :logline, length: { maximum: 300, wrong_length: "Logline can be at most %{count} characters" }
  
  validate :valid_start_date, :if => 'start_date.present?'
  
  scope :unapproved, -> { where(:approved => false) }
  
  private
  def valid_start_date
    errors[:start_date] << "Start date must be in the future" if start_date < Time.zone.today
  end
end
