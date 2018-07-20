Rails.application.routes.draw do
  resources :users, only: [:show]
  devise_for :users, path: 'user', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

	resources :shows do
		resources :episodes, controller: 'shows/episodes' do
			put :favorite, on: :member
				resources :comments
		end	
	end

	resources :genres, only: [:show]

	get '/archive' => 'shows/episodes#index'
	get '/highlights' => 'highlights#index'
	get '/explore' => 'shows/episodes#explore'
	get 'search' => 'search#index'

  root 'home#index'
end
