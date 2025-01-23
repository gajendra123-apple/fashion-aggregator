Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "admin/dashboard#index"
  # Defines the root path route ("/")
  # root "posts#index"
  # resources :sub_categories
  # resources :categories
  # resources :categories do
  #   collection do
  #    get 'filter_product_by_category'
  #   end
  # end

  resources :categories do  
    resources :sub_categories, only: [:index]
    collection do
      get 'filter_product_by_category'
    end 
  end
  
  resources :products do
    collection do
      get 'sort_product'
      get 'filter_product_by_size'
      post 'filter_product_by_brand_names'
      get 'filter_product_by_colors'
      get 'list_of_product_brand_names'
      get 'list_of_product_colors'
      get 'list_of_product_sizes'
      get 'list_of_product_category'
      get 'filter_product_by_category'
    end
  end

  post '/users/sign_up', to: 'users#sign_up'
  post '/users/login', to: 'users#login'
  post 'users/forgot_password', to: 'users#forgot_password'
  patch 'users/reset_password/:token', to: 'users#reset_password', as: 'reset_password_token'
  post '/cart_items/add_product', to: 'cart_items#add_product'
  delete '/cart_items/remove_product', to: 'cart_items#remove_product'
  post '/reviews/add_reviews', to: 'reviews#add_reviews'
  post 'orders/buy_now', to: 'orders#buy_now' 
  post 'orders/placed_order_with_cart', to: 'orders#placed_order_with_cart' 
  # get '/reviews/customer_review', to: 'reviews#customer_review'
  resources :favorites
  resources :brands

  resource :carts, only: [:show] do
    post 'add_product'
    delete 'remove_product'
    post 'apply_coupon'
    post 'checkout'
  end
  
  resources :orders
  resources :reviews do
    collection do
      get 'customer_review'
    end
  end

  resources :razorpays, only: [:new, :create, :index] do
    collection do
     post '/create_razorpay_order', to: 'razorpays#create_razorpay_order'
     post '/capture_payment', to: 'razorpays#capture_payment'
     post 'create_razorpay_order'
    end
  end
 
  resources :coupons
end