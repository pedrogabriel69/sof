Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'questions#index'

  post '/create_answer', to: 'answers#create'

  resources :questions do
    resources :answers
  end
end
