Rails.application.routes.draw do
  resources :users, except: :index
  resources :users, only: [:edit, :update]
  resources :artworks

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'sessions#welcome'

  get 'login', to: 'sessions#login', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'register', to: 'users#register', as: 'register'
  post 'register', to: 'users#create'
  get 'upload', to: 'image_search#upload', as: 'upload'
  post 'search', to: 'image_search#search', as: 'search'
end
