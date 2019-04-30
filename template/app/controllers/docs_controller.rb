class DocsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'admin'

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
