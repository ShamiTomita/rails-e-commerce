Rails.application.routes.draw do
  resources :order_items
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  get '/profile', to: "users#profile", as: "profile"
  get '/checkout/:id', to: "orders#checkout", as: "checkout"
  get "/checkout/:id/shipping", to: "orders#shipping", as: "shipping"
  get '/items', to: "orders#checkout_items"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  resources :line_items do
    member do
      post :edit
    end
  end
  resources :orders
  resources :products
  resources :users
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'public#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
