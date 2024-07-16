Rails.application.routes.draw do
  get "/users/logout" => "users#logout"
  get "/users/login" => "users#login"
  post "/users/login" => "users#verify"
  get "/users/register" => "users#new"
  get "/users/:id/following" => "follow#following"
  get "/users/:id/followers" => "follow#followers"
  post "/users/:id/follow" => "follow#create"
  get "/users/:id/unfollow/:source" => "follow#destroy"
  delete "/users/:id/unfollow/:source" => "follow#destroy"
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#login"
end
