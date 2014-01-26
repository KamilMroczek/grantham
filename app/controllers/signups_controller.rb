class SignupsController < ApplicationController
  # GET /signups
  # GET /signups.json
  def index
    @signups = Signup.all
  end

  # GET /signups/new
  def new
    @signup = Signup.new
  end
  
  def finish
  end

  # POST /signups
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
      params.require(:signup).permit(:email, :imdb, :linkedin, :photo)
    end
end
