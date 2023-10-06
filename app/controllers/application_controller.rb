# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder

  respond_to :json
  before_action :authenticate_user!
end
