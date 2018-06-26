Rails.application.routes.draw do
  resources :users, only: [:show]

  devise_for :users, path: 'user', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home#index'
end
