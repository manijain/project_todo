class Project < ApplicationRecord
  has_many :assignments
  has_many :employees, through: :assignments
  has_many :todos, dependent: :destroy
end
