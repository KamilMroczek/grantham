module ProjectsHelper
  def build_project(override_params = {})
    skill = Skill.create(:name => "skill1")
    project_attrs = FactoryGirl.attributes_for(:project)
    project = Project.new(project_attrs.merge(override_params))
    project.skills << skill
    project
  end
  
  def create_project(override_params = {})
    project = build_project(override_params)
    project.save
    project
  end
end