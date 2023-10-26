Rails.application.routes.draw do
  root 'homes#top'

  resources :users, only: %i[new create]
end
