Rails.application.routes.draw do
  root to: 'pages#home'

  resources :calculations, only: [:new, :create]
  resources :compensations, only: [:new]
end
