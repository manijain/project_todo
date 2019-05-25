class DashboardController < ApplicationController
  def index
    if employee_signed_in?
      if current_employee.is_employee?
        @todos = current_employee.todos
      elsif current_employee.is_manager?
        @employees = Employee.all
        @projects = Project.all
        @employee_todos = Todo.includes(:employee).order("status asc").group_by(&:status)
        @project_todos = Todo.includes(:project).order("status asc").group_by(&:status)
        @todo_status_count = Todo.group(:status).count
      end
    end
  end

  def assign_todo
    if params[:todo_id].present? && params[:employee_id].present? 
      @todo = Todo.find(params[:todo_id])
      update_params = { assigned_by_id: current_employee.id, employee_id: params[:employee_id].to_i }
      respond_to do |format|
        if @todo.update(update_params)
          format.html { redirect_to project_todos_path(@todo.project, @todo), notice: 'Todo was successfully Assigned.' }
          format.json { render :show, status: :ok, location: @todo }
        else
          format.html { render :index }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def assign_project
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

  def update_todo
    if params[:todo_id].present? && params[:status].present?
      todo = Todo.find(params[:todo_id])
      @todos = current_employee.todos
      respond_to do |format|
        if todo.update(status: params[:status])
          format.html { redirect_to root_path, notice: 'Todo status successfully changed.' }
          format.json { render :show, status: :ok, location: todo }
        else
          format.html { render :index }
          format.json { render json: todo.errors, status: :unprocessable_entity }
        end
      end 
    end
  end
end
