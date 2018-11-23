module V1
  class ApiController < ApplicationController
    before_action :authenticate!
  
    def current_user
      @current_user
    end
  
    private
  
    def authenticate!
      begin
        auth  = request.headers["Authorization"]
        token = auth.split(' ').last
        
        payload = Jwt.decode(token)

        @current_user = User.find_by(id: payload['sub'])
    
        if @current_user
          set_locale @current_user.preference.locale
        else
          unauthorized
        end
      rescue StandardError => e
        unauthorized
      end
    end
  end
end
