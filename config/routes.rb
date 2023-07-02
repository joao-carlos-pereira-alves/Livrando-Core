# frozen_string_literal: true

Rails.application.routes.draw do
  constraints subdomain: /.*/ do
    namespace :api do
      namespace :v1 do
        defaults format: :json do
          resources :movies
          post '/movies/import', to: 'movies#import'
        end
      end
    end
  end
end
