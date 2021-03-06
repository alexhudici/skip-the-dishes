require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :orders, only: [:show]
  jsonapi_resources :restaurants do
    jsonapi_resources :dishes, except: [:create]
  end

  jsonapi_resources :customers

  resources :restaurants do
    resources :dishes, only: [:create]
  end

  post 'customers/:customer_id/orders/surprise', to: 'orders#surprise_order'
  post 'customers/:customer_id/orders', to: 'orders#create'

  mount Sidekiq::Web => '/sidekiq'
end
