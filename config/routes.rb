Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources :vacancies do
    get 'search', on: :collection
    post 'apply', on: :member
    get 'registered', on: :collection
    post 'feature', on: :member
    get 'reject', on: :member
  end
  resources :profiles
  resources :comments do
    post 'post', on: :member
  end
  resources :feedbacks do
    post 'decline', on: :member
  end
  resources :entries do
    resources :proposals do
      get 'confirm', on: :member
      get 'refuse', on: :member
    end
  end
  resources :reports do
    post 'positive', on: :member
    post 'negative', on: :member
  end
end
