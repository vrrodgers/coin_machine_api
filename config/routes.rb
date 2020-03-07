Rails.application.routes.draw do
  resources :transactions
  namespace :api do
    namespace :v1 do
      resources :coins, param: :slug
      resources :transactions
    end
  end  
  resources :users
end
