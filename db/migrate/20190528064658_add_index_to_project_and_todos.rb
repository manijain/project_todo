class AddIndexToProjectAndTodos < ActiveRecord::Migration[5.2]
  def change
    add_index :projects, :name
    add_index :todos, [:name, :project_id, :employee_id]
    add_index :assignments, [:project_id, :employee_id]
  end
end
