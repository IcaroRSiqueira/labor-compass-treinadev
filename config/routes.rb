Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :vacancies do
    get 'search', on: :collection
    post 'apply', on: :member
    get 'registered', on: :collection
  end
  resources :profiles
end
