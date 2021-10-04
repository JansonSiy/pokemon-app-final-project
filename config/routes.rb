Rails.application.routes.draw do
  # resources :home
  resources :cards

  post 'battle/:id/user_attack', to:'home#user_attack', as: :user_attack
  post 'battle/:id/heal', to:'home#heal', as: :heal

  root to: "home#index"

  get '/pokedex', to: 'cards#pokedex'
  get '/challenge', to: 'cards#index'
  get '/deck', to: 'cards#deck'
  get '/hello', to: 'home#hello'
  patch 'select/:id',to:'cards#select_card' , as: :select

  get '/users', to: 'users#index'
  get '/battle/:id', to: 'home#battle', as: :battle

  devise_for :users, controllers: {
     sessions: 'users/sessions',
     passwords: 'users/passwords',
     registrations: 'users/registrations'
  }
end