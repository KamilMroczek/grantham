require "spec_helper"

describe ProjectsController do
  describe "routing" do
    it "routes to #index" do
      get("/projects").should route_to("projects#index")
    end
    
    it "routes to #new" do
      get("/projects/new").should route_to("projects#new")
    end
    
    it "routes to #create" do
      post("/projects").should route_to("projects#create")
    end
    
    it "routes to #approve" do
      get("/projects/1/approve").should route_to({ "action"=>"approve", "controller"=>"projects", "id"=>"1" })
    end
  end
end
