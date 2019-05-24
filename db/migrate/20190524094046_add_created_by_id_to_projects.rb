class AddCreatedByIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :created_by_id, :integer
  end
end
