Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'questions#index'

  resources :questions do
    resources :answers
  end
end
