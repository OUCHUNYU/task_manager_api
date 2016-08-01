Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :show]
  resources :projects, only: [:index, :create, :update, :destroy, :show]
  resources :tasks, only: [:index, :create, :update, :destroy, :show]
end
