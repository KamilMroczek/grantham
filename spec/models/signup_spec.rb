# == Schema Information
#
# Table name: signups
#
#  id         :integer          not null, primary key
#  email      :string(256)      not null
#  imdb       :string(256)
#  website    :string(256)
#  approved   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Signup do
  
  describe "#create" do
    let (:attrs) { FactoryGirl.attributes_for(:signup) }
    
    it "should require an email" do
      FactoryGirl.build(:signup, attrs.merge(:email => nil)).should_not be_valid
    end
    it "should NOT accept a blank email" do
      FactoryGirl.build(:signup, attrs.merge(:email => "  ")).should_not be_valid
    end
    
    context "when a signup from the same user exists already" do
      before do
        FactoryGirl.create(:signup, :email => "same@email.com")
      end
      it "should NOT allow creation of a signup with the same email" do
        FactoryGirl.build(:signup, attrs.merge(:email => "same@email.com")).should_not be_valid
      end
      it "should allow creation of a signup with a different email" do
        FactoryGirl.build(:signup, attrs.merge(:email => "diff@email.com")).should be_valid
      end
    end
    
    context "when has only an IMDB link" do
      before do
        attrs.merge!(:website => nil)
      end
      it "should allow it" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://www.imdb.com/name/1")).should be_valid
      end
      it "should fix partial links" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "www.imdb.com/name/1")).should be_valid
        FactoryGirl.build(:signup, attrs.merge!(:website => "https://www.personal.com/person")).should be_valid
      end
      it "should NOT allow a malformed imdb link" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://ww.imdb.com/name/1")).should_not be_valid
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://www.imd.com/name/1")).should_not be_valid
      end
    end
    
    context "when has only a website link" do
      before do
        attrs.merge!(:imdb => nil)
      end
      it "should allow it" do
        FactoryGirl.build(:signup, attrs.merge!(:website => "http://www.personal.com/person")).should be_valid
      end
      it "should fix partial links" do
        FactoryGirl.build(:signup, attrs.merge!(:website => "www.personal.com/person")).should be_valid
        FactoryGirl.build(:signup, attrs.merge!(:website => "https://www.personal.com/person")).should be_valid
      end
    end
    
    context "when has both a personal and IMDB links" do
      it "should allow it" do
        attrs.merge!( :email => "valid@gmail.com", 
                      :imdb => "http://www.imdb.com/name/1",
                      :website => "http://www.personal.com/person" )
        FactoryGirl.build(:signup, attrs).should be_valid
      end
    end
    
  end
end
