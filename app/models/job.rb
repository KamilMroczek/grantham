# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  skill_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Job < ActiveRecord::Base
  belongs_to :project
  belongs_to :skill
end
