class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :employee, optional: true
  
  validates :name, :description, presence: :true
end
