Rails.application.routes.draw do
  get 'admin/index'
  get 'admin/products'
  get 'admin/orders'
  get 'admin/users'
  resources :order_items
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  get '/profile', to: "users#profile", as: "profile"
  get '/about', to:"public#about", as: "about"
  get '/contact', to:"public#contact", as:"contact"

  get "success", to: "orders#success"

  get '/items', to: "orders#checkout_items"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"

  get 'dashboard' => "users#admin_dashboard", as: "dashboard"
  delete 'line_items/:id' => "line_items#destroy"
  resources :line_items do
    member do
      post :edit
    end
  end
  resources :orders
  resources :products
  resources :contacts
  resources :users, only: [:edit, :update]
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'public#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
