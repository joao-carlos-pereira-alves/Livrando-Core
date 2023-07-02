# frozen_string_literal: true

module Api
  module V1
    module Users
      # PasswordsController
      class PasswordsController < Devise::PasswordsController
        # GET /resource/password/new
        def new
          self.resource = resource_class.new
        end

        # POST /resource/password
        def create
          email = params[:email]
          user = User.find_by(email: email)
          if user
            token = user.send(:set_reset_password_token)
          else
            render 'not_found', status: :not_found
          end
        end

        # GET /resource/password/edit?reset_password_token=abcdef
        def edit
          self.resource = resource_class.new
          set_minimum_password_length
          resource.reset_password_token = params[:reset_password_token]
        end

        # PUT /resource/password
        # def update
        #   super do
        #     resource.update_attribute(:password, params[:password])
        #     resource.update_attribute(:password_confirmation, params[:password_confirmation])
        #   end
        # end

        protected

        def after_resetting_password_path_for(resource)
          Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
        end

        # The path used after sending reset password instructions
        def after_sending_reset_password_instructions_path_for(resource_name)
          new_session_path(resource_name) if is_navigational_format?
        end

        # Check if a reset_password_token is provided in the request
        def assert_reset_token_passed
          return unless something params[:reset_password_token].blank?

          set_flash_message(:alert, :no_token)
          redirect_to new_session_path(resource_name)
        end

        # Check if proper Lockable module methods are present & unlock strategy
        # allows to unlock resource on password reset
        def unlockable?(resource)
          resource.respond_to?(:unlock_access!) &&
            resource.respond_to?(:unlock_strategy_enabled?) &&
            resource.unlock_strategy_enabled?(:email)
        end

        def translation_scope
          'devise.passwords'
        end
      end
    end
  end
end