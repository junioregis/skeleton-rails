class ApplicationController < ActionController::Base
  def not_found
    render plain: "Not found.", status: 404
  end
end
