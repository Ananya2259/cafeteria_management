Rails.application.routes.draw do
  # get "/" => "home#index"
  root to: "home#index"
  resources :users
  resources :main_menu
  resources :main
  resources :menu_categories
  resources :menu_items
  resources :cart_items
  resources :orders
  resources :order_items
  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
