require 'spec_helper'
include ProjectsHelper

describe ProjectsController do
  render_views
  
  before do
    FactoryGirl.create(:skill)
  end
  
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
    let(:attrs) do 
      { "title" => "ATitle", 
        "logline" => "logline", 
        "start_date" => Time.zone.today.strftime("%m/%d/%Y"),
        "jobs_attributes" => ["1"]
      }
    end
    
    context "when the creation is successful" do
      before do
        @project = create_project
        ProjectHelper.stub(:create).and_return([@project, true])
      end
      it "redirects to the new project path" do
        post :create, :project => attrs
        response.should redirect_to(projects_path)
      end
      it "passes in the correct project params for creation" do
        ProjectHelper.should_receive(:create).with(attrs).once.and_return([@project, true])
        post :create, :project => attrs
      end
      it "sets the proper flash message" do
        post :create, :project => attrs
        flash[:notice].should =~ /Added project/
      end
    end
    
    context "when the creation fails" do
      before do
        @project = build_project
        ProjectHelper.stub(:create).and_return([@project, false])
      end
      it "renders the new action" do
        post :create, :project => attrs
        response.should render_template(:new)
      end
    end
  end
  
  describe "#index" do
    it "lists all unapproved projects" do
      Project.should_receive(:unapproved).once.and_return([])
      get :index
    end
    it "succeeds" do
      get :index
      response.should be_success
    end
  end
  
  describe "#approve" do
    before do
      @project = create_project
    end
    
    context "when the approval succeeds" do
      it "renders the index action" do
        get :approve, :id => @project.id
        response.should redirect_to projects_path
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
    
    context "when the approval fails" do
      before do
        Project.any_instance.stub(:update_attributes).and_return(false)
      end
      it "renders the index action" do
        get :approve, :id => @project.id
        response.should redirect_to projects_path
      end
      it "DOES NOT approve the project" do
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