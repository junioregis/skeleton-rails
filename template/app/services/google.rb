module Google
  module User
    def self.get(access_token)
      url = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=#{access_token}"
      call = HTTParty.get(url, headers: { 'Content-Type' => 'application/json; charset=utf-8' })

      if call.response.code == '200'
        begin
          user = call.parsed_response

          { id:     user['id'],
            email:  user['email'],
            name:   user['name'],
            gender: user['gender'],
            avatar: user['picture'] }
        rescue StandardError => e
          raise SocialError::Google.new e
        end
      else
        raise SocialError::Google
      end
    end
  end
end