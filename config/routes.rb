Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources :vacancies do
    get 'search', on: :collection
    post 'finalize', on: :member
  end
  resources :entries do
    post 'apply', on: :member
    post 'feature', on: :member
    post 'unfeature', on: :member
    get 'registered', on: :collection
    get 'reject', on: :member
  end
  resources :profiles, only: [:new, :create, :edit, :update, :show]
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
  namespace :api do
    namespace :v1 do
      resources :vacancies, only: %i[show index]
    end
  end
end
