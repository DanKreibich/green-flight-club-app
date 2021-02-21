Rails.application.routes.draw do
  root to: 'pages#home'

  resources :calculations, only: [:new, :create]
  resources :compensations, only: [:new, :create]

  # added to receive the hidden calculation_id parameter from the previous hidden form on calculations/create screen
  post 'compensations/new', to: 'compensations#new'
end
