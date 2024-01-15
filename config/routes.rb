Rails.application.routes.draw do
  root   'homes#top'
  get    'login',             to: 'user_sessions#new'
  post   'login',             to: 'user_sessions#create'
  delete 'logout',            to: 'user_sessions#destroy'
  get    'privacy_policy',    to: 'homes#privacy_policy'
  get    'terms_of_service',  to: 'homes#terms_of_service'

  resources :users, only: %i[new create]
  resources :items do
    collection do
      get :search_name
      get :search_tag
      get :situation
    end
  end
  resources :favorites, only: %i[create destroy]
  resource  :profiles, only: %i[show edit update] do
    get :bookmark_tab, on: :collection
  end

  resources :password_resets, only: %i[new create edit update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
