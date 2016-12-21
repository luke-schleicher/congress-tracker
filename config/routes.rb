Rails.application.routes.draw do

  root 'sessions#new'

  resources :reps
  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
