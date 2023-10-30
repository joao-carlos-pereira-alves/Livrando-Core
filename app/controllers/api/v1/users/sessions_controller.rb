# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
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