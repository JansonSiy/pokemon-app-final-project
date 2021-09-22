Rails.application.routes.draw do
  get '/users', to: 'users#index'
  resources :cards
  root to: "home#index"
  get '/users', to: 'cards#index'
  devise_for :users, controllers: {
	   sessions: 'users/sessions',
	   passwords: 'users/passwords',
	   registrations: 'users/registrations'
  }
end