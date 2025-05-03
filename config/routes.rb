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
  # For health checks (default)
  get "up" => "rails/health#show", as: :rails_health_check
  get '/my-tools', to: 'tools#my_tools', as: :user_tools
end
