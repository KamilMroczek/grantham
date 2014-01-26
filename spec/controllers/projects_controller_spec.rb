require 'spec_helper'

describe ProjectsController do
  describe "GET new" do
    it "should succeed" do
      get :new
    end
  end
end