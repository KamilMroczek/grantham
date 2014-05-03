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
  include ProjectsHelper
  
  describe "#create" do  
    it "allows a project with all valid attributes" do
      build_project.should be_valid
    end
    it "defaults approved to false" do
      build_project.approved.should be_false
    end
    
    describe "title" do
      it "does NOT allow a project with a nil title" do
        build_project(title: nil).should_not be_valid
        build_project(title: "").should_not be_valid
        build_project(title: " ").should_not be_valid
      end
      it "does NOT allow a project with a title > 60 characters" do
        build_project(title: ("A" * 61)).should_not be_valid
      end
    end
    
    describe "logline" do
      it "does NOT allow a project without a log line" do
        build_project(logline: nil).should_not be_valid
        build_project(logline: "").should_not be_valid
        build_project(logline: " ").should_not be_valid
      end
      it "allows a project with a log line of 300 characters" do
        build_project(logline: ("A" * 300)).should be_valid
      end
      it "does NOT allow a project with a log line > 301 characters" do
        build_project(logline: ("A" * 301)).should_not be_valid
      end
    end
    
    describe "start_date" do
      it "doesn't allow a blank start date" do
        build_project(start_date: nil).should_not be_valid
      end
      it "allows a start date of today" do
        build_project(start_date: Time.zone.today).should be_valid
      end
      it "allows a start date in the future" do
        build_project(start_date: Time.zone.today + 1.day).should be_valid
      end
      it "does NOT allow a start date in the past" do
        build_project(start_date: Time.zone.today - 1.day).should_not be_valid
      end
    end
  end
  
  describe "update" do
    describe "approved" do
      context "when the project start date is in the past" do
        before do
          Timecop.freeze(Time.current)
          @project = create_project(start_date: Time.zone.today)
        end
        after do
          Timecop.return
        end
        
        it "allows you to approve the project" do
          Timecop.travel(Time.current + 2.days)
          @project.update_attributes(:approved => true).should be_true
        end
      end
      
      context "when the project start date is current or in the future" do
        before do
          @project = create_project(start_date: Time.zone.today)
        end
        
        it "allows you to approve the project" do
          @project.update_attributes(:approved => true).should be_true
        end
      end
    end
  end
end
