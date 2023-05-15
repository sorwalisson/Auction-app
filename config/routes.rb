Rails.application.routes.draw do
  devise_for :users, :controllers => {:sessions => "custom_sessions"}
  root to: 'home#index'
  get 'admin_menu', action: :admin_menu, controller: "home"
  
  resources :won_auctions, only: :index
  resource :search, only: :show
  resources :auction_lots, only: [:show, :new, :create, :show, :edit, :update] do
    resources :items, only: [:new, :create, :show] do
      post 'change_auction', on: :member
    end
    resources :bids, only: [:create]
    post 'awaiting_confirmation', on: :member
    post 'confirmed', on: :member
    post 'validated', on: :member
    post 'canceled', on: :member
  end
end
