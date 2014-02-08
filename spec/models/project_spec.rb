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

require 'spec_helper'

describe Project do
  
  describe "#create" do
    it "allows a project with all valid attributes" do
      FactoryGirl.build(:project).should be_valid
    end
    it "defaults approved to false" do
      FactoryGirl.build(:project).approved.should be_false
    end
    
    describe ".title" do
      it "does NOT allow a project without a title" do
        FactoryGirl.build(:project, title: nil).should_not be_valid
        FactoryGirl.build(:project, title: "").should_not be_valid
        FactoryGirl.build(:project, title: " ").should_not be_valid
      end
      it "does NOT allow a project with a title > 60 characters" do
        FactoryGirl.build(:project, title: ("A" * 61)).should_not be_valid
      end
    end
    
    describe ".logline" do
      it "does NOT allow a project without a log line" do
        FactoryGirl.build(:project, logline: nil).should_not be_valid
        FactoryGirl.build(:project, logline: "").should_not be_valid
        FactoryGirl.build(:project, logline: " ").should_not be_valid
      end
      it "allows a project with a log line of 300 characters" do
        FactoryGirl.build(:project, logline: ("A" * 300)).should be_valid
      end
      it "does NOT allow a project with a log line > 301 characters" do
        FactoryGirl.build(:project, logline: ("A" * 301)).should_not be_valid
      end
    end
    
    describe ".start_date" do
      it "allows a blank start date" do
        FactoryGirl.build(:project, start_date: nil).should be_valid
      end
      it "allows a start date of today" do
        FactoryGirl.build(:project, start_date: Time.zone.today).should be_valid
      end
      it "allows a start date in the future" do
        FactoryGirl.build(:project, start_date: Time.zone.today + 1.day).should be_valid
      end
      it "does NOT allow a start date in the past" do
        FactoryGirl.build(:project, start_date: Time.zone.today - 1.day).should_not be_valid
      end
    end
  end
end
