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

require 'spec_helper'

describe Project do
  
  describe "#create" do
    it "should allow a project with all valid attributes" do
      FactoryGirl.build(:project).should be_valid
    end
    
    it "should NOT allow a project without a title" do
      FactoryGirl.build(:project, title: nil).should_not be_valid
      FactoryGirl.build(:project, title: "").should_not be_valid
      FactoryGirl.build(:project, title: " ").should_not be_valid
    end
    it "should NOT allow a project with a title > 60 characters" do
      FactoryGirl.build(:project, title: ("A" * 61)).should_not be_valid
    end
    
    it "should NOT allow a project without a log line" do
      FactoryGirl.build(:project, logline: nil).should_not be_valid
      FactoryGirl.build(:project, logline: "").should_not be_valid
      FactoryGirl.build(:project, logline: " ").should_not be_valid
    end
    it "should allow a project with a log line of 140 characters" do
      FactoryGirl.build(:project, logline: ("A" * 140)).should be_valid
    end
    it "should NOT allow a project with a log line > 140 characters" do
      FactoryGirl.build(:project, logline: ("A" * 141)).should_not be_valid
    end
    
    it "should allow a project without a description" do
      FactoryGirl.build(:project, description: nil).should be_valid
      FactoryGirl.build(:project, description: "").should be_valid
      FactoryGirl.build(:project, description: " ").should be_valid
    end
    it "should allow a project with a description of 500 characters" do
      FactoryGirl.build(:project, description: ("A" * 500)).should be_valid
    end
    it "should NOT allow a project with a description > 500 characters" do
      FactoryGirl.build(:project, description: ("A" * 501)).should_not be_valid
    end
    
    it "should allow a start date of today" do
      FactoryGirl.build(:project, start_date: Time.zone.today).should be_valid
    end
    it "should allow a start date in the future" do
      FactoryGirl.build(:project, start_date: Time.zone.today + 1.day).should be_valid
    end
    it "should NOT allow a blank start date" do
      FactoryGirl.build(:project, start_date: nil).should_not be_valid
    end
    it "should NOT allow a start date in the past" do
      FactoryGirl.build(:project, start_date: Time.zone.today - 1.day).should_not be_valid
    end
    
    it "should allow a file image" do
      FactoryGirl.build(:project, cover_image: File.new(Rails.root + 'spec/images/test-image.png')).should be_valid
    end
    it "should NOT allow a project without an image" do
      FactoryGirl.build(:project, cover_image_file_name: nil).should_not be_valid
      FactoryGirl.build(:project, cover_image_file_name: "").should_not be_valid
      FactoryGirl.build(:project, cover_image_file_name: " ").should_not be_valid
    end
  end
  
end
