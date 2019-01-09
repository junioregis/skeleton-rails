require 'net/http'

# Google Service
#
# Scopes:
#   - https://www.googleapis.com/auth/userinfo.email
#   - https://www.googleapis.com/auth/userinfo.profile
#   - https://www.googleapis.com/auth/user.birthday.read
#
# Get Access Token:
#   https://developers.google.com/oauthplayground

class GoogleService < SocialService
  URL = 'https://people.googleapis.com/v1/people/me'
  FIELDS = 'emailAddresses,names,genders,birthdays,photos'

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
    URI.parse("#{URL}?access_token=#{@auth_code}&personFields=#{FIELDS}")
  end

  def user
    response = Net::HTTP.get_response(url_info)

    if response.code == '200'
      json = JSON.parse(response.body)
      json.deep_symbolize_keys!

      date = json[:birthdays].filter {|item| item[:metadata][:source][:type] == 'ACCOUNT'}.first[:date]

      birthday_year = date[:year]
      birthday_month = date[:month]
      birthday_day = date[:day]

      birthday = Date.new birthday_year, birthday_month, birthday_day

      gender = json[:genders].first[:value]

      avatar = json[:photos].first[:url]
      avatar.gsub! /\A(.+)\/(.+)\/(.+\..+)\z/, "\\1/s#{AVATAR_SIZE}/"

      data = {}
      data[:provider] = :google
      data[:provider_id] = json[:names].first[:metadata][:source][:id]
      data[:email] = json[:emailAddresses].first[:value]
      data[:name] = json[:names].first[:displayName]
      data[:gender] = gender == 'male' ? :male : :female
      data[:birthday] = birthday
      data[:avatar] = avatar
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
