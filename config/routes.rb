# config/routes.rb
Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  resources :articles
  resources :users, only: [:new, :create]
  
  root 'articles#index'
end
