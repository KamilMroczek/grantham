require 'spec_helper'

describe ProjectsController do
  describe "GET new" do
    it "succeeds" do
      get :new
    end
    it "creates a new instance" do
      get :new
      assigns(:project).should_not be_nil
    end
  end
  
  describe "#create" do
    let(:attrs) { { "title" => "ATitle", "logline" => "logline", "start_date" => Time.zone.today.strftime("%m/%d/%Y") } }
    
    context "when the creation is successful" do
      it "redirects to the new project path" do
        post :create, :project => attrs
        response.should redirect_to(projects_path)
      end
      it "should create the project with the proper params" do
        post :create, :project => attrs
        p = Project.last
        p.title.should == attrs["title"]
        p.logline.should == attrs["logline"]
        p.start_date.strftime("%m/%d/%Y").should == attrs["start_date"]
      end
      it "sets the proper flash message" do
        post :create, :project => attrs
        flash[:notice].should =~ /Added project/
      end
    end
    
    context "when the creation fails" do
      before do
        Project.any_instance.stub(:save).and_return(false)
      end
      it "renders the new action" do
        post :create, :project => attrs
        response.should render_template(:new)
      end
    end
  end
  
  describe "#index" do
    it "lists all unapproved projects" do
      Project.should_receive(:unapproved).once
      get :index
    end
    it "succeeds" do
      get :index
      response.should be_success
    end
  end
  
  describe "#approve" do
    before do
      @project = FactoryGirl.create(:project)
    end
    
    context "when the approval fails" do
      it "renders the index action" do
        get :approve, :id => @project.id
        response.should render_template(:index)
      end
      it "approves the project" do
        get :approve, :id => @project.id
        @project.reload.approved.should be_true
      end
      it "sets the flash" do
        get :approve, :id => @project.id
        flash[:notice].should =~ /Approved project/
      end
    end
    
    context "when the approval succeeds" do
      before do
        Project.any_instance.stub(:update_attributes).and_return(false)
      end
      it "renders the index action" do
        get :approve, :id => @project.id
        response.should render_template(:index)
      end
      it "DOES NOT approves the project" do
        get :approve, :id => @project.id
        @project.reload.approved.should be_false
      end
      it "sets the flash" do
        get :approve, :id => @project.id
        flash[:notice].should =~ /Unable to approve project/
      end
    end
  end
end