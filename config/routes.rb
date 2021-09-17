Rails.application.routes.draw do
  # devise_for :users
  resources :tests

  root to: "home#index"
  devise_for :users, controllers: {
	   sessions: 'users/sessions',
	   passwords: 'users/passwords',
	   registrations: 'users/registrations'
  }
end
