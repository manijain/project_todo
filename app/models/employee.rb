class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  has_many :assignments
  has_many :projects, through: :assignments
  has_many :todos

  validates :first_name, :last_name, :role_id, presence: :true
  
  def is_employee?
    role.present? ? role.try(:name) == "Developer" : true
  end

  def is_manager?
    role.present? ? role.try(:name) == "Manager" : false
  end

  def displayname
    first_name+' '+last_name
  end

  def self.get_available_employees(project, emp_id)
    ids = project.employees.map(&:id)
    ids << emp_id
    where.not(id: ids)
  end

end
