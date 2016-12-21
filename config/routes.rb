Rails.application.routes.draw do

  root 'sessions#new'

  resources :reps

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
