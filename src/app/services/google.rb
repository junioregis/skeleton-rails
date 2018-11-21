module Google
  module User
    def self.get(access_token)
      url = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=#{access_token}"
      call = HTTParty.get(url, headers: {'Content-Type' => 'application/json'})

      if call.response.code == '200'
        begin
          user = call.parsed_response

          {id:        user['id'],
           email:     user['email'],
           name:      user['name'],
           gender:    user['gender'],
           locale:    user['locale'].gsub('-', '_'),
           photo_url: user['picture']}
        rescue Exception
          nil
        end
      else
        nil
      end
    end
  end
end