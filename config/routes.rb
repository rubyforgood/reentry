Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  resources :domains
  resources :locations
  resources :location_services, only: [:index]

  resources :downloads
end
