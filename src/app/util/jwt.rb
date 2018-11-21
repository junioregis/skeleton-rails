require 'jwt'

class Jwt
  class << self
    def encode(user)
      payload = { sub: user.id }
      payload.merge! meta

      begin
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      rescue StandardError => e
        raise JwtError.new e
      end
    end

    def decode(token)
      begin
        JWT.decode(token, Rails.application.credentials.secret_key_base).first
      rescue StandardError => e
        raise JwtError.new e
      end
    end

    def meta
      {
        exp: expiration,
        iss: 'api',
        aud: 'mobile'
      }
    end

    def expiration
      3.day.from_now.to_i
    end
  end
end
