Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :coins, param: :slug
    end
  end  
  resources :users
end
