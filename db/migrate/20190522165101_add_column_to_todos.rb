class AddColumnToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :project_id, :integer
    add_column :todos, :employee_id, :integer
    add_column :todos, :status, :string
  end
end
