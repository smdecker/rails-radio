Rails.application.routes.draw do
  resources :users, only: [:show]

  devise_for :users, path: 'user'

  root 'home#index'
end
