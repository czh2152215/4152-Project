Rails.application.routes.draw do
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'sessions#welcome'
  get 'login', to: 'sessions#login', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout', as: 'logout'
  get 'register', to: 'user#register', as: 'register'
  resources :user, only: [:create]
  get 'upload', to: 'image_search#upload', as: 'upload'
end
