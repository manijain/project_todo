class DashboardController < ApplicationController
  def index
    if employee_signed_in?
      if current_employee.is_employee?
        @todos = Todo.where(employee_id: current_employee.id)
      elsif current_employee.is_manager?
        @project = current_employee.projects
      end
    end
  end

  def assign_todo
    if params[:todo_id].present? && params[:employee_id].present? 
      @todo = Todo.find(params[:todo_id])
      respond_to do |format|
        if @todo.update(employee_id: params[:employee_id].to_i, status: "New", assigned_by_id: current_employee.id)
          format.html { redirect_to project_todos_path(@todo.project, @todo), notice: 'Todo was successfully Assigned.' }
          format.json { render :show, status: :ok, location: @todo }
        else
          format.html { render :index }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def assign_employee
    if params[:project_id].present? && params[:employee_id].present? 
      @project = Project.find(params[:project_id])
      @employee = Employee.find(params[:employee_id])
      @assignment = Assignment.new(employee_id: @employee.id, project_id: @project.id, assigned_by_id: current_employee.id)
      respond_to do |format|
        if @assignment.save
          format.html { redirect_to project_path(@project), notice: 'Project successfully assigned.' }
          format.json { render :show, status: :ok, location: @todo }
        else
          format.html { render :index }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
