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
    #TO DO create user record
    @signup.update_attributes!(:approved => true)
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
