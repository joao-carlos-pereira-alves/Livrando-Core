# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder

  respond_to :json
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_status

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :cpf, :phone, :password, :password_confirmation])
  end

  def check_user_status
    if user_signed_in? && current_user&.blocked?
      sign_out current_user

      response = { error: "Sua conta foi bloqueada. Entre em contato com o suporte." }

      render json: response, status: :unauthorized
    end
  end
end
