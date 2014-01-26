require "spec_helper"

describe SignupsController do
  describe "routing" do
    it "routes to #index" do
      get("/signups").should route_to("signups#index")
    end
    
    it "routes to #new" do
      get("/signups/new").should route_to("signups#new")
    end
    
    it "routes to #create" do
      post("/signups").should route_to("signups#create")
    end
    
    it "routes to #finish" do
      get("/signups/finish").should route_to("signups#finish")
    end
  end
end
