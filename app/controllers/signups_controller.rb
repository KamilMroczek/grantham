class SignupsController < ApplicationController
  
  before_filter :set_signup, :only => [:approve]

  def index
    @signups = Signup.where(:approved => false)
  end

  def new
    @signup = Signup.new
  end
  
  def finish
  end
  
  def approve
    new_user = UserCreator.new.create_user(@signup)
    if new_user.errors.count.zero?
      @signup.update_attributes!(:approved => true)
      flash[:notice] = "New user added #{new_user.email}"
    else
      flash[:notice] = "Errors adding user #{@signup.email}. #{new_user.errors.full_messages}"
    end
    redirect_to :action => 'index'
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
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signup_params
      params.require(:signup).permit(:email, :imdb, :website, :photo)
    end
end
