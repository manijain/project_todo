class AddRoleIdToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :role_id, :integer
  end
end
