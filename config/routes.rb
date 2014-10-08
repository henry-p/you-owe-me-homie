Dwellings::Application.routes.draw do
  resources :users do
    resources :households do
      resources :comments
      resources :transactions do
        resources :comments
      end
    end
  end
end



# @households = UsersHouseholds.where(user: current_user)

# @household = UsersHousehold.where()
