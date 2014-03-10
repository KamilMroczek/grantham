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
  
  describe "GET edit" do
    let(:signup) { FactoryGirl.create :signup, :approved => false }
    
    it "assigns a new signup as @signup" do
      get :edit, :id => signup.id
      assigns(:signup).should eq(signup)
    end
  end
  
  describe "POST update" do
    describe "with valid signup" do
      let(:signup) { FactoryGirl.create :signup, :approved => false }
      it "creates a new User" do
        params = { :id => signup.id, 'signup' => { :skills => ['1','2'] } }
        expect { put :update, params }.to change(User, :count).by(1)
      end
      it "approves the signup" do
        params = { :id => signup.id, 'signup' => { :skills => ['1','2'] } }
        put :update, params
        signup.reload.should be_approved
      end
      it "sets the flash notice to" do
        params = { :id => signup.id, 'signup' => { :skills => ['1','2'] } }
        put :update, params
        flash[:notice].should =~ /new user added/i
      end
    end
    
    describe "with invalid signup" do
      let(:signup) { FactoryGirl.create :signup, :approved => false }
      before do
        errors = ["error1"]
        errors.stub(:full_messages).and_return("other errors")
        mock_user = double(User)
        mock_user.stub(:errors).and_return(errors)
        UserCreator.any_instance.stub(:create_user).and_return(mock_user)
        @params = { :id => signup.id, :signup => { :skills => ['1'] } }
      end
      it "should not create a new user" do
        expect { put :update, @params }.not_to change(User, :count)
      end
      it "doesn't approve the signup" do
        put :update, @params
        signup.reload.should_not be_approved
      end
      it "sets the flash notice to" do
        put :update, @params
        flash[:notice].should =~ /other errors/i
      end
    end
    
    describe "with no skills" do
      let(:signup) { FactoryGirl.create :signup, :approved => false }
      it "should not create a new user" do
        expect { put :update, :id => signup.id }.not_to change(User, :count)
      end
      it "doesn't approve the signup" do
        put :update, :id => signup.id
        signup.reload.should_not be_approved
      end
      it "instructs user to select a skill" do
        put :update, :id => signup.id
        flash[:notice].should =~ /please select a skill/i
      end
    end
    
    describe "with empty skills" do
      let(:signup) { FactoryGirl.create :signup, :approved => false }
      before do
        @params = { :id => signup.id, :signup => { :skills => [''] } }
      end
      it "should not create a new user" do
        expect { put :update, @params }.not_to change(User, :count)
      end
      it "doesn't approve the signup" do
        put :update, @params
        signup.reload.should_not be_approved
      end
      it "instructs user to select a skill" do
        put :update, @params
        flash[:notice].should =~ /please select a skill/i
      end
    end
  end
end
