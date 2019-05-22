class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer :employee_id
      t.integer :project_id
      t.integer :assigned_by_id
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
