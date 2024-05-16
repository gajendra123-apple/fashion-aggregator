Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  resources :subcategories
  # resources :products
  # resources :cart_items
  resources :products do
    collection do
      get 'sort_product'
    end
  end
  get '/products/sort_product', to: 'products#sort_product'
  post '/users/sign_up', to: 'users#sign_up'
  post '/users/login', to: 'users#login'
  post 'users/forgot_password', to: 'users#forgot_password'
  patch 'users/reset_password/:token', to: 'users#reset_password', as: 'reset_password_token'
  post '/cart_items/add_product', to: 'cart_items#add_product'
  delete '/cart_items/remove_product', to: 'cart_items#remove_product'

  resources :favorites
end