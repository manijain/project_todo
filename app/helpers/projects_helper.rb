module ProjectsHelper
  def get_assignee(employee, project)
    assignment = Assignment.where(employee_id: employee.id, project_id: project.id).last
    Employee.find(assignment.assigned_by_id).try(:displayname)
  end
end
