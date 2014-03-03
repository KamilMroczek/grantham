require 'spec_helper'

describe UserCreator do
  subject { UserCreator.new }
  describe "#create_user" do
    let(:signup) {  FactoryGirl.create(:signup, :email => "email@email.com", 
                                                :imdb => "http://www.imdb.com", 
                                                :website => "http://www.website.com")
    }
    
    it "creates a single user" do
      expect { subject.create_user(signup, []) }.to change(User, :count).by(1)
    end
    it "creates a user with the same email" do
      user = subject.create_user(signup, [])
      user.email.should == "email@email.com"
    end
    it "creates a user with the same imdb link" do
      user = subject.create_user(signup, [])
      user.imdb.should == "http://www.imdb.com"
    end
    it "creates a user with the same website link" do
      user = subject.create_user(signup, [])
      user.website.should == "http://www.website.com"
    end
    
    context "when saving an invalid signup" do
      before do
        signup.imdb = nil
        signup.website = nil
      end
      it "attaches errors to the user object" do
        user = subject.create_user(signup, [])
        user.errors.count.should > 0
      end
      it "doesn't create a user" do
        expect { subject.create_user(signup, []) }.not_to change(User, :count)
      end
    end
    
    describe "associating skills" do
      it "should create a skill association for each skill" do
        expect { subject.create_user(signup, ['1', '2']) }.to change(UserSkill, :count).by 2
      end
    end
  end
end