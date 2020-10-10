Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/edit'
  root 'static_pages#home'
  resources :users
  resources :restaurants do
    resource :favorites,    only: [:create, :destroy ]
  end
  resources :comments,      only: [:create, :destroy]
  resources :notifications, only: :index
  resources :categories, except: [:new, :show]
  resources :boards
  resources :board_comments, only: [:create, :destroy]
  get    :signup,        to: 'users#new'
  get    :login,         to: 'sessions#new'
  post   :login,         to: 'sessions#create'
  delete :logout,        to: 'sessions#destroy'
  get    :favorites,     to: 'favorites#index'
  get    '/auth/:provider/callback' => 'users#omniauth'
  post   :'/guest',      to: 'guest_sessions#create' 
end
