Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'

  resources :users, only: [:new, :create, :show]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
