Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
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
    resources :answers, concerns: [:votable] do
      member do
        put :best
      end
      resources :comments, only: [:create], defaults: { context: 'answer' }
    end
    resources :comments, only: [:create], defaults: { context: 'question' }
  end

  mount ActionCable.server => '/cable'
end
