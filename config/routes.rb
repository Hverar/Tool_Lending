Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tools, only: [:index, :new, :create, :show] do
    resources :bookings, only: [:new, :create]  # ✅ nested — needs tool_id
  end

  resources :bookings, only: [:update, :destroy]  # ✅ flat — uses booking id

  # For health checks (default)
  get "up" => "rails/health#show", as: :rails_health_check
end
