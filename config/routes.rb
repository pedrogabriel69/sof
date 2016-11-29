Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'questions#index'

  resources :attachments, only: :destroy

  resources :questions do
    member do
      get :like
      get :unlike
    end
    resources :answers do
      member do
        put :best
        get :like
        get :unlike
      end
    end
  end
end
