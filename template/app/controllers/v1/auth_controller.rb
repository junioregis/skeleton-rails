module V1
  class AuthController < ApiController
    rescue_from AuthError, with: :auth_error

    skip_before_action :authenticate!, only: [:token]

    def token
      begin
        info = case auth_params[:provider]
                when 'facebook'
                  Facebook::User.get(auth_params[:access_token])
                when 'google'
                  Google::User.get(auth_params[:access_token])
                else
                  raise AuthError::InvalidProvider
                end
      rescue SocialError => e
        raise AuthError.new e
      end

      user = User.find_by(email: info[:email]) || User.new

      user.email       = info[:email]
      user.provider    = auth_params[:provider]
      user.provider_id = info[:id]

      user.preference.locale = :pt_BR
      user.preference.unit   = :km
      
      user.profile.name   = info[:name]
      user.profile.gender = info[:gender]
      user.profile.avatar.attach(io: open(info[:avatar]), filename: 'avatar')

      type = user.new_record? ? 'signUp' : 'signIn'

      if user.save!
        begin
          token = Jwt.encode(user)
          
          set_locale user.preference.locale

          headers = { 
            'Auth-Token' => token,
            'Expiration' => Jwt.expiration,
            'Type'       => type
          }
          
          r headers: headers, message: 'auth.success'
        rescue JwtError => e
          raise AuthError.new e
        end
      else
        raise AuthError
      end
    end

    private

    def auth_params
      params.permit :provider, :provider_id, :access_token
    end

    def auth_error(e)
      log e
      r message: 'auth.error'
    end
  end
end
