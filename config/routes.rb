Rails.application.routes.draw do
  
  resources :projects do
    resources :todos
  end
  
  get 'dashboard/index'
  get 'dashboard/assign_todo'
  devise_for :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
end
