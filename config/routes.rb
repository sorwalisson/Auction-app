Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'admin_menu', action: :admin_menu, controller: "home"

  resources :items, only: [:show]
  resources :auction_lots, only: [:show, :new, :create, :show, :edit, :update] do
    resources :items, only: [:new, :create, :show]
    post 'awaiting_confirmation', on: :member
    post 'confirmed', on: :member
  end
end
