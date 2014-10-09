Dwellings::Application.routes.draw do

  root "sessions#new"
  post "/login" => "sessions#create", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"
  get "/groups/:group_id/bills" => "bills#new", as: "new_group_bill"
  get "/groups/:group_id/payments" => "payments#new", as: "new_group_payment"
  post "/groups/:group_id/bills" => "bills#create", as: "group_bills"
  post "/groups/:group_id/payments" => "payments#create", as: "group_payments"

  resources :groups, except: [:index] do
    resources :comments, only: [:new, :create, :show]
    resources :transactions, only: [:delete, :show] do
      resources :comments, only: [:new, :create, :show]
    end
  end

  resources :users, only: [:new, :create, :show]
end
