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
    
    it "routes to #approve" do
      get("/signups/1/approve").should route_to({ "action"=>"approve", "controller"=>"signups", "id"=>"1" })
    end
  end
end
