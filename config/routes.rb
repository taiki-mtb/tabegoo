Rails.application.routes.draw do
 root 'static_pages#home'
  get :signup,       to: 'users#new'
  resources :users
  resources :restaurants do
    resource :favorites, only: [:create, :destroy ]
  end
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  get    :favorites, to: 'favorites#index'
end
