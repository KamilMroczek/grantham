class SignupsController < ApplicationController

  def index
    @signups = Signup.where(:approved => false)
  end

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)

    if @signup.save
      render action: 'finish' #, notice: 'Signup was successfully created.' }
    else
      @signup.errors.full_messages.each do |err| ap err end
      render action: 'new'
    end
  end
  
  def edit
    set_signup
  end
  
  def update
    set_signup
    skills = params['signup'].try(:[], 'skills')
    skills.select!(&:present?) unless skills.nil?
    if skills.nil? || skills.count < 1
      flash[:notice] = "Errors adding user #{@signup.email}. Please select a skill."
    else
      new_user = UserCreator.new.create_user(@signup, skills)
      if new_user.errors.count.zero?
        @signup.update_attributes!(:approved => true)
        flash[:notice] = "New user added #{new_user.email}"
      else
        flash[:notice] = "Errors adding user #{@signup.email}. #{new_user.errors.full_messages}"
      end
    end
    redirect_to :action => 'index'
  end
  
  private
    def set_signup
      @signup = Signup.find(params[:id])
    end

    def signup_params
      params.require(:signup).permit(:email, :imdb, :website, :photo, :skills)
    end
end
