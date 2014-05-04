class ProjectHelper
  def self.create(project_params)
    project_params["start_date"] = convert_date_to_mdy(project_params["start_date"])
    project_params["jobs_attributes"] = convert_job_attributes(project_params["jobs_attributes"])
    
    project = Project.new(project_params)
    saved = project.save
    
    [project, saved]
  end
  
  private
  def self.convert_date_to_mdy(date)
    Date.strptime(date, "%m/%d/%Y")
  rescue
    nil
  end
  
  def self.convert_job_attributes(job_attributes)
    if job_attributes
      job_attributes.map { |skill_id| { :skill_id => skill_id.to_i } }
    else
      []
    end
  end
  
end