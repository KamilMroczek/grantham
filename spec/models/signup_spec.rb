# == Schema Information
#
# Table name: signups
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  imdb       :string(128)
#  linkedin   :string(128)
#  photo      :string(256)
#  approved   :boolean          default(FALSE)
#  complete   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Signup do
  
  describe "#create" do
    let (:attrs) { FactoryGirl.attributes_for(:signup) }
    
    it "should require an email" do
      attrs.merge!(:email => nil)
      FactoryGirl.build(:signup, attrs).should_not be_valid
    end
    it "should NOT accept a blank email" do
      attrs.merge!(:email => "  ")
      FactoryGirl.build(:signup, attrs).should_not be_valid
    end
    
    context "when has only an IMDB link" do
      before do
        attrs.merge!(:linkedin => nil)
      end
      it "should allow it" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://www.imdb.com/name/1")).should be_valid
      end
      it "should fix partial links" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "www.imdb.com/name/1")).should be_valid
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "https://www.linkedin.com/person")).should be_valid
      end
      it "should NOT allow a malformed imdb link" do
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://ww.imdb.com/name/1")).should_not be_valid
        FactoryGirl.build(:signup, attrs.merge!(:imdb => "http://www.imd.com/name/1")).should_not be_valid
      end
    end
    
    context "when has only a LinkedIn link" do
      before do
        attrs.merge!(:imdb => nil)
      end
      it "should allow it" do
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "http://www.linkedin.com/person")).should be_valid
      end
      it "should fix partial links" do
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "www.linkedin.com/person")).should be_valid
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "https://www.linkedin.com/person")).should be_valid
      end
      it "should NOT allow a malformed LinkedIn link" do
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "http://ww.linkedin.com/person")).should_not be_valid
        FactoryGirl.build(:signup, attrs.merge!(:imdb => nil, :linkedin => "http://www.linkedi.com/person")).should_not be_valid
        FactoryGirl.build(:signup, attrs.merge!(:linkedin => "http://www.linkedi.com/person")).should_not be_valid
      end
    end
    
    context "when has both LinkedIn an IMDB links" do
      it "should allow it" do
        attrs.merge!( :email => "valid@gmail.com", 
                      :imdb => "http://www.imdb.com/name/1",
                      :linkedin => "http://www.linkedin.com/person" )
        FactoryGirl.build(:signup, attrs).should be_valid
      end
    end
    
  end
end
