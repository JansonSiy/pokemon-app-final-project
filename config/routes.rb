Rails.application.routes.draw do
  # get 'cards/index'
  resources :tests
  resources :cards
end
