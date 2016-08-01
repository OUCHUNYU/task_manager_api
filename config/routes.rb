Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :show]
  resources :projects, only: [:create, :update, :destroy, :show]
  resources :tasks, only: [:create, :update, :destroy, :show]
end
