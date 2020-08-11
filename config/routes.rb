Rails.application.routes.draw do
 root 'static_pages#home'
  get :signup,       to: 'users#new'
  resources :users
  resources :restaurants
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  post   "favorites/:restaurant_id/create"  => "favorites#create"
  delete "favorites/:restaurant_id/destroy" => "favorites#destroy"
end
