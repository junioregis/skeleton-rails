module Facebook
  module User
    def self.get(access_token)
      fields = %w(email name gender picture.width(512).height(512)).join(',')

      url = "https://graph.facebook.com/v3.2/me?access_token=#{access_token}&fields=#{fields}&format=json"
      call = HTTParty.get(url, headers: { 'Content-Type' => 'application/json; charset=utf-8' })

      if call.response.code == '200'
        begin
          user = JSON(call.parsed_response)

          { id:     user['id'],
            email:  user['email'],
            name:   user['name'],
            gender: user['gender'],
            avatar: user['picture']['data']['url'] }
        rescue StandardError => e
          raise SocialError::Facebook.new e
        end
      else
        raise SocialError::Facebook
      end
    end
  end
end