require 'spec_helper'

describe SignupsController do
  
  # This should return the minimal set of attributes required to create a valid
  let(:valid_attributes) { { "email" => "email@email.com", "imdb" => "www.imdb.com/name/123" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all signups as @signups" do
      signup = Signup.create! valid_attributes
      get :index, {}, valid_session
      assigns(:signups).should eq([signup])
    end
  end

  describe "GET new" do
    it "assigns a new signup as @signup" do
      get :new
      assigns(:signup).should be_a_new(Signup)
    end
  end
  
  describe "GET finish" do
    it "should succeed" do
      get 'finish'
      response.should be_success
    end
  end
    
  describe "POST create" do
    describe "with valid params" do
      it "creates a new Signup" do
        expect {
          post :create, {:signup => valid_attributes}, valid_session
        }.to change(Signup, :count).by(1)
      end
  
      it "assigns a newly created signup as @signup" do
        post :create, {:signup => valid_attributes}, valid_session
        assigns(:signup).should be_a(Signup)
        assigns(:signup).should be_persisted
      end
  
      it "redirects to the created signup" do
        post :create, {:signup => valid_attributes}, valid_session
        response.should render_template('finish')
      end
    end
  
    describe "with invalid params" do
      it "assigns a newly created but unsaved signup as @signup" do
        # Trigger the behavior that occurs when invalid params are submitted
        Signup.any_instance.stub(:save).and_return(false)
        post :create, {:signup => { "email" => "invalid value" }}, valid_session
        assigns(:signup).should be_a_new(Signup)
      end
  
      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Signup.any_instance.stub(:save).and_return(false)
        post :create, {:signup => { "email" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end
end
