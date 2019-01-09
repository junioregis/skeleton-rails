require 'net/http'

class SlackService
  URL = 'https://slack.com/api/chat.postMessage'

  def initialize
    @token = Rails.application.credentials.slack[:token]
    @channel = Rails.application.credentials.slack[:channel]
  end

  def send(title, message)
    uri = URI(URL)

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': "Bearer #{@token}"
    }

    request = Net::HTTP::Post.new(URL, headers)
    request.body = {
        channel: "\##{@channel}",
        text: "*#{title}*\n\n#{message}"
    }.to_json

    response = https.request(request)

    if response.code == '200'
      body = JSON.parse(response.body)
      body.deep_symbolize_keys!

      unless body[:ok]
        Log.error "Slack: #{body[:error]}"
      end
    end
  rescue StandardError => e
    Log.error e
  end
end