Rails.application.routes.draw do
  root "home#index"

  devise_for :users,
           controllers: {
             omniauth_callbacks: "users/omniauth_callbacks"
           }

  resources :posts, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index]
  resources :contacts, only: [:create, :destroy]

  resources :messages, only: [:index, :create]

  get "chat/:user_id",
      to: "messages#chat",
      as: :chat

  resources :conversations, only: [:index, :new, :create, :show] do
    post :send_message, on: :member
  end

  resources :notifications, only: [:index] do
  patch :mark_as_read, on: :member
  end

  get "up" => "rails/health#show", as: :rails_health_check
end