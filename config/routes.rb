Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users
  resources :restaurants do
    resource :favorites,    only: [:create, :destroy ]
  end
  resources :comments,      only: [:create, :destroy]
  resources :notifications, only: :index
  get    :signup,        to: 'users#new'
  get    :login,         to: 'sessions#new'
  post   :login,         to: 'sessions#create'
  delete :logout,        to: 'sessions#destroy'
  get    :favorites,     to: 'favorites#index'
end
