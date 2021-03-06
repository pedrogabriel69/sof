require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper

  devise_for :users, controllers: { registrations: 'registrations',
                                    omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    post '/sign_in_email' => 'omniauth_callbacks#sign_in_email'
  end

  root 'questions#index'

  concern :votable do
    member do
      get :like
      get :unlike
    end
  end

  resources :attachments, only: :destroy
  resources :questions, concerns: [:votable] do
    member do
      put :unsubscribe
    end
    resources :answers, concerns: [:votable] do
      member do
        put :best
      end
      resources :comments, only: [:create], defaults: { context: 'answer' }
    end
    resources :comments, only: [:create], defaults: { context: 'question' }
    resources :follows, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :index, on: :collection
      end
      resources :questions, except: [:edit, :update, :destroy] do
        resources :answers, except: [:edit, :update, :destroy]
      end
    end
  end

  resources :users, only: [:index, :show] do
    member do
      put :change_daily_digest
    end
  end

  mount ActionCable.server => '/cable'

  get 'search', to: 'searches#index'
  post '/search_result', to: 'searches#search'
end
