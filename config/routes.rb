Rails.application.routes.draw do
  resources :home

  post 'home/:id/user_attack', to:'home#user_attack', as: :user_attack
  post 'home/:id/gym_leader_attack', to:'home#gym_leader_attack', as: :gym_leader_attack

  resources :cards

  root to: "home#index"

  get '/users', to: 'cards#index'

  devise_for :users, controllers: {
	   sessions: 'users/sessions',
	   passwords: 'users/passwords',
	   registrations: 'users/registrations'
  }
  
  # resources :battle
end