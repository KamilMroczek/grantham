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

require 'spec_helper'

describe Job do
  include ProjectsHelper
  
  describe "#create" do
    let(:skill) { FactoryGirl.build(:skill) }
    let(:project) { create_project }
    
    it "succeeds if both a project and skill are present" do
      FactoryGirl.build(:job, :skill => skill, :project => project).should be_valid
    end
  end
end
