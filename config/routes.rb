Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users/position_order', to: 'users#update_position_order'

  resources :users, only: [:create, :show]
  resources :projects, only: [:create, :update, :destroy, :show]
  resources :tasks, only: [:create, :update, :destroy, :show]
end
