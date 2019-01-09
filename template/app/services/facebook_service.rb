require 'net/http'

# Facebook Service
#
# Scopes:
#   - email
#   - user_gender
#   - user_birthday
#
# Get Access Token:
#   https://developers.facebook.com/tools/explorer

class FacebookService < SocialService
  URL = 'https://graph.facebook.com/v3.2/me'
  FIELDS = "id,name,email,gender,birthday,picture.width(#{AVATAR_SIZE}).height(#{AVATAR_SIZE})"

  def initialize(auth_code)
    @auth_code = auth_code
    @user = user
  end

  def get_user!
    if @user.present?
      User.authorize_from_external(@user)
    else
      nil
    end
  end

  private

  def url_info
    URI.parse("#{URL}?access_token=#{@auth_code}&fields=#{FIELDS}")
  end

  def user
    response = Net::HTTP.get_response(url_info)

    if response.code == '200'
      info = JSON.parse(response.body)
      info.deep_symbolize_keys!

      data = {}
      data[:provider] = :facebook
      data[:provider_id] = info[:id]
      data[:email] = info[:email]
      data[:name] = info[:name]
      data[:gender] = info[:gender] == 'male' ? :male : :female
      data[:birthday] = Date.strptime info[:birthday], '%m/%d/%Y'
      data[:avatar] = info[:picture][:data][:url]
      data
    else
      log_error response
    end
  end

  def log_error(response)
    json = JSON.parse(response.body)
    json.deep_symbolize_keys!

    message = json[:error][:message]

    Log.error message
  end
end
