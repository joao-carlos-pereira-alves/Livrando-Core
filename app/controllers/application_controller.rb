# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder
end
