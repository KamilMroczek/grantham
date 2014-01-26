require 'spec_helper'

describe WelcomeController do
  describe "routing" do
    it "routes to to #splash" do
      get("/welcome/splash").should route_to("welcome#splash")
    end
  end
end