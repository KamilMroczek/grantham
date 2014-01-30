# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(256)      not null
#  imdb       :string(256)
#  website    :string(256)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  describe "#create" do
    let (:attrs) { FactoryGirl.attributes_for(:user) }
    
    it "should require an email" do
      FactoryGirl.build(:user, attrs.merge!(:email => nil)).should_not be_valid
    end
    it "should NOT accept a blank email" do
      FactoryGirl.build(:user, attrs.merge!(:email => "  ")).should_not be_valid
    end
    
    context "when an user with the same email already exists" do
      before do
        FactoryGirl.create(:user, :email => "same@email.com")
      end
      it "should NOT allow creation of another user with the same email" do
        FactoryGirl.build(:user, attrs.merge!(:email => "same@email.com")).should_not be_valid
      end
      it "should allow a user with a different email" do
        FactoryGirl.build(:user, attrs.merge!(:email => "diff@email.com")).should be_valid
      end
    end
    
    it "should require an IMDB link or website link" do
      FactoryGirl.build(:user, attrs.merge!(:imdb => nil, :website => nil)).should_not be_valid
    end
    it "should allow a user to have an imdb link but no website link" do
      FactoryGirl.build(:user, attrs.merge!(:imdb => "http://www.imdb.com", :website => nil)).should be_valid
    end
    it "should allow a user to have a website link but no IMDB link" do
      FactoryGirl.build(:user, attrs.merge!(:imdb => nil, :website => "http://www.website.com")).should be_valid
    end
    it "should allow a user to have both an IMDB link and a website link" do
      FactoryGirl.build(:user, attrs.merge!(:imdb => "http://www.imdb.com", :website => "http://www.website.com")).should be_valid
    end
  end
end
