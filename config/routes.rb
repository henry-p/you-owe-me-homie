Dwellings::Application.routes.draw do

  root "sessions#new"
  post "/login" => "sessions#create", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"

  resources :households, except: [:index] do
    resources :comments, only: [:new, :create, :show]
    resources :transactions do
      resources :comments, only: [:new, :create, :show]
    end
  end

  resources :users, only: [:new, :create, :show]
end
