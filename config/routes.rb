Rails.application.routes.draw do
  resources :mining_types
  get 'wellcome/index'
  resources :coins
  #get '/coins', to: 'coins#index'
  #get '/coins/new', to: 'coins#new', as: 'new_coin'

  root to: 'wellcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
