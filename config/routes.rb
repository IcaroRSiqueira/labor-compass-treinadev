Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources :vacancies do
    get 'search', on: :collection
    post 'apply', on: :member
    get 'registered', on: :collection
  end
  resources :profiles
  resources :comments do
    post 'post', on: :member
  end
end
