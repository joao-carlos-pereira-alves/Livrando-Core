# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/websocket'

  constraints subdomain: /.*/ do
    devise_for(
      :users,
      path: '',
      path_names: {
        sign_in: 'api/v1/login',
        sign_out: 'api/v1/logout',
        registration: 'api/v1/signup',
        password: 'api/v1/reset_password'
      },
      controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        passwords: 'api/v1/users/passwords'
      },
      defaults: { format: :json }
    )

    namespace :api do
      namespace :v1 do
        defaults format: :json do
          resources :books
          resources :reports
          resources :ratings
          resources :trades
          resources :categories
          resources :favorite_books
          resources :chats
          resources :users
          post "favorite_books/deslike", to: "favorite_books#deslike"
          get "show_user_with_uuid/:uuid", to: "users#show"
<<<<<<< HEAD
=======
          get "chat_with_chat_user_id", to: "chats#chat_with_chat_user_id"
>>>>>>> save-dev
        end
      end
    end
  end
end
