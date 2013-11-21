class ProjectsController < ApplicationController
  
  def new
    @project = Project.new
  end
  
  def create
    convert_date
    @project = Project.new(project_params)
    if @project.save
      redirect_to new_project_path
    else
      render :action => "new"
    end
  end
  
  private
  def convert_date
    project_params["start_date"] = Date.strptime(project_params["start_date"], "%m/%d/%Y")
  rescue
    project_params["start_date"] = nil
  end

  def project_params
    @project_params ||= params.require(:project).permit(:title, :logline, :description, :start_date, { :skills => [] }, :cover_image)
  end
end