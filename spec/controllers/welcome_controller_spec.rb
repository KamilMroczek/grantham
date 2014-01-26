require 'spec_helper'

describe WelcomeController do
  describe "GET splash" do
    it "should succeed" do
      get 'splash'
    end
  end
end