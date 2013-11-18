class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  
  def create
    success = Project.create(project_params)
    if success
      redirect_to new_project_path
    else
      render :action => "new"
    end
  end
  
  private
  def project_params
    params.require(:project).permit(:title, :logline, :description, :start_date, :skills, :cover_image)
  end
end