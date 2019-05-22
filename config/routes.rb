Rails.application.routes.draw do
  resources :todos
  resources :projects
  get 'dashboard/index'
  devise_for :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
end
