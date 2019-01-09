class DocsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: 'admin', password: 'admin'

  skip_before_action :doorkeeper_authorize!

  def postman
    @endpoints = $endpoints
    @version = docs_params[:version]

    render partial: @version
  end

  private

  def docs_params
    params.permit :version
  end
end
