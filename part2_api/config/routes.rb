Rails.application.routes.draw do
  post "/signup", to: "authentication#signup"
  post "/auth/login", to: "authentication#login"
  get "/auth/logout", to: "authentication#logout"

  resources :todos, only: [:index, :create, :show, :update, :destroy] do
    resources :items, only: [:show, :create, :update, :destroy]
  end
end