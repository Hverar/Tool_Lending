Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tools, only: [:index, :new, :create, :show, :edit, :update] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:update, :destroy] do
    member do
      patch :accept
      patch :decline
    end
  end

  # Custom routes
  get '/my-tools', to: 'tools#my_tools', as: :user_tools
  get '/my-bookings', to: 'bookings#my_bookings', as: :user_bookings
  get '/profile', to: 'profiles#show', as: :user_profile

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
