Rails.application.routes.draw do
  
  resources :projects do
    resources :todos
  end
  
  get 'dashboard/index'
  post 'dashboard/assign_todo'
  post 'dashboard/assign_employee'
  devise_for :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
end
