Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'questions#index'

  # put '/questions/:question_id/answers/:id/best', to 'answers#best'

  resources :questions do
    resources :answers do
      member do
        put :best
      end
    end
  end
end
