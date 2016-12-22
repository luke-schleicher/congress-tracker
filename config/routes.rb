Rails.application.routes.draw do

  root 'sessions#new'

  resources :users, only: [:create]
  resources :legislators, param: :bioguide_id
  resources :bills, param: :bill_id
  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
