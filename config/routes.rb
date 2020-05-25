Rails.application.routes.draw do
  get "accounts/search", to: "accounts#search"
  resources :accounts, only: %i[index show create destroy] do
    resources :vehicles
    resources :bookings
    resources :identities
  end
  resources :vehicles
  resources :bookings
  resources :identities

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
