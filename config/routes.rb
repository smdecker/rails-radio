Rails.application.routes.draw do
  resources :users, only: [:show]
  devise_for :users, path: 'user', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

	resources :shows do
		resources :episodes, controller: 'shows/episodes' do
			put :favorite, on: :member
				resources :comments, only: [:create]
		end	
	end

	get '/archive' => 'shows/episodes#index'

  root 'home#index'
end
