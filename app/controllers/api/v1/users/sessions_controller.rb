# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        def create
          user = User.find_by(email: params[:user][:email])

          if user && user.status == :blocked
            render status: :unauthorized, json: { error: "Sua conta foi bloqueada. Entre em contato com o suporte." }
          else
            super do |user|
              user.update(last_seen: Time.now)
            end
          end
        end
  
        private

        def respond_with(resource, _opts = {})
          if resource.errors.empty?
            render partial: 'api/v1/users/authentication', locals: { user: resource }
          else
            render json: resource.errors.full_messages, status: :unauthorized
          end
        end

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end