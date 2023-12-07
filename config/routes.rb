Rails.application.routes.draw do
  get 'reset_password/new'
  get 'reset_password/create'
  get 'reset_password/edit'
  get 'reset_password/update'
  root   'homes#top'
  get    'login',             to: 'user_sessions#new'
  post   'login',             to: 'user_sessions#create'
  delete 'logout',            to: 'user_sessions#destroy'
  get    'privacy_policy',    to: 'homes#privacy_policy'
  get    'terms_of_service',  to: 'homes#terms_of_service'

  resources :users, only: %i[new create]
  resources :items do
    get :search, on: :collection
  end
  resources :favorites, only: %i[create destroy]
  resource  :profiles, only: %i[show edit update] do
    get :bookmark_tab, on: :collection
  end

end
