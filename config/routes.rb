Rails.application.routes.draw do
  get 'accounts/search', to: 'accounts#search'
  resources :accounts, only: %i[index show create destroy]
  resources :vehicles
  resources :bookings
  resources :identities

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
