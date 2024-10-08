# frozen_string_literal: true

Rails.application.routes.draw do
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
          resources :favorite_books
        end
      end
    end
  end
end
