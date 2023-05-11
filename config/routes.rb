Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'admin_menu', action: :admin_menu, controller: "home"
  
  resources :auction_lots, only: [:show, :new, :create, :show, :edit, :update] do
    resources :items, only: [:new, :create, :show]
    resources :bids, only: [:create]
    post 'awaiting_confirmation', on: :member
    post 'confirmed', on: :member
  end
end
