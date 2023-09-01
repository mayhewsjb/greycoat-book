Rails.application.routes.draw do
  devise_for :users
  resources :stays, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  root to: 'stays#index'
  resources :rooms, only: [:index, :show]
end
