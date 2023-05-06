Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'admin_menu', action: :admin_menu, controller: "home"

  resources :items, only: [:show]
  resources :auction_lots, only: [:show]
end
