class ProjectsController < ApplicationController

  def index
    @projects = Project.unapproved
  end
  
  def new
    @project = Project.new
    @skills = Skill.all
  end
  
  def create
    @project, saved = ProjectHelper.create(project_params)
    if saved
      flash[:notice] = "Added project #{@project.title}."
      redirect_to projects_path
    else
      @skills = Skill.all
      render :action => :new
    end
  end
  
  def approve
    @project = Project.find(params[:id])
    if @project.update_attributes(:approved => true)
      flash[:notice] = "Approved project #{@project.title}."
    else
      flash[:notice] = "Unable to approve project #{@project.title}. #{@project.errors.full_messages.first}"
    end
    redirect_to :action => :index
  end
  
  private  
  def project_params
    @project_params ||= params.require(:project).permit( :title, :logline, :start_date, :jobs_attributes => [])
  end
end