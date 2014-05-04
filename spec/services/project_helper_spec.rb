require 'spec_helper'

describe ProjectHelper do
  describe ".create" do
    before do
      @skill = FactoryGirl.create(:skill)
      @skill2 = FactoryGirl.create(:skill)
    end
    
    context "when passing in valid attributes" do
      let(:attrs) do
        { "title" => "ATitle", 
          "logline" => "logline", 
          "start_date" => Time.zone.today.strftime("%m/%d/%Y"),
          "jobs_attributes" => [@skill.id.to_s, @skill2.id.to_s]
        }
      end
      
      it "returns success" do
        project, saved = ProjectHelper.create(attrs)
        saved.should be_true
      end
      it "saves the project" do
        project, saved = ProjectHelper.create(attrs)
        project.should be_persisted
      end
      it "returns a project object with the proper fields saved" do
        project, saved = ProjectHelper.create(attrs)
        project.title.should == attrs['title']
        project.logline.should == attrs['logline']
      end
      it "converts the date to the proper format" do
        project, saved = ProjectHelper.create(attrs)
        project.start_date.should == Time.zone.today
      end
      it "associates the skills to the project" do
        project, saved = ProjectHelper.create(attrs)
        project.skills.should =~ [@skill, @skill2]
      end
    end
    
    context "when passing in invalid attributes" do
      let(:attrs_no_title) do
        { "logline" => "logline", 
          "start_date" => Time.zone.today.strftime("%m/%d/%Y"),
          "jobs_attributes" => [@skill.id.to_s, @skill2.id.to_s]
        }
      end
      
      it "returns failure" do
        project, saved = ProjectHelper.create(attrs_no_title)
        saved.should be_false
      end
      it "doesn't save the project" do
        project, saved = ProjectHelper.create(attrs_no_title)
        project.should_not be_persisted
      end
      it "returns a project object with the proper fields set" do
        project, saved = ProjectHelper.create(attrs_no_title)
        project.title.should be_nil
        project.logline.should == attrs_no_title['logline']
      end
      it "converts the date to the proper format" do
        project, saved = ProjectHelper.create(attrs_no_title)
        project.start_date.should == Time.zone.today
      end
      it "doesn't associate any skills to the project" do
        project, saved = ProjectHelper.create(attrs_no_title)
        project.skills.should == []
      end
    end
  end
end