class ProjectsController < ApplicationController
  
  def index
    @projects = Project.unapproved
  end
  
  def new
    @project = Project.new
  end
  
  def create
    convert_date
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Added project #{@project.title}."
      redirect_to projects_path
    else
      render :action => :new
    end
  end
  
  def approve
    @project = Project.find(params[:id])
    if @project.update_attributes(:approved => true)
      flash[:notice] = "Approved project #{@project.title}."
    else
      flash[:notice] = "Unable to approve project #{@project.title}."
    end
    redirect_to :action => :index
  end
  
  private
  def convert_date
    project_params["start_date"] = Date.strptime(project_params["start_date"], "%m/%d/%Y")
  rescue
    project_params["start_date"] = nil
  end
  
  def project_params
    @project_params ||= params.require(:project).permit(:title, :logline, :start_date)
  end
end