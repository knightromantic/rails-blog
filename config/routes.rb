Rails.application.routes.draw do
  get "users/new"
  get "users/create"
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Article resources routes
  resources :articles

  # Set the root path to the articles index
  root "articles#index"
  
  #log
  resources :sessions, only: [:new, :create, :destroy]
get 'signup', to: 'users#new'

end

