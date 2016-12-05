Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'questions#index'

  resources :attachments, only: :destroy

  concern :votable do
    member do
      get :like
      get :unlike
    end
  end

  resources :questions, concerns: [:votable] do
    resources :answers, concerns: [:votable] do
      member do
        put :best
      end
    end
  end

  mount ActionCable.server => '/cable'
end
