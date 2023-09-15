Rails.application.routes.draw do
  get 'pages/info'
  devise_for :users

  resources :stays, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    get 'my_stays', on: :collection
    get 'available_rooms', on: :collection  # Adding the new route
  end

  root to: 'stays#index'
  resources :rooms, only: [:index, :show]
  get '/fetch_stays', to: 'stays#fetch_stays'
  get '/fetch_my_stays', to: 'stays#fetch_my_stays'

  resources :todos do
    member do
      patch :toggle_status
    end
  end

  get 'info', to: 'pages#info'
end
