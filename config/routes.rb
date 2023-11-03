Rails.application.routes.draw do
  root   'homes#top'
  get    'login',  to: 'user_sessions#new'
  post   'login',  to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :items
  resource  :profiles, only: %i[show edit update]
end
