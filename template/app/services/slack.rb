module Slack
  def self.send(title, message)
    url = 'https://slack.com/api/chat.postMessage'

    token   = Rails.application.credentials.slack[:token]
    channel = Rails.application.credentials.slack[:channel]

    body = {
        channel: "\##{channel}",
        text:    "*#{title}*\n\n#{message}"
    }

    call = HTTParty.post(url, headers: { 'Content-Type'  => 'application/json; charset=utf-8',
                                         'Authorization' => "Bearer #{token}" },
                         body: body.to_json)

    response = call.response

    if response.code == '200'
      response_body = call.parsed_response

      raise SlackError.new(response_body['error']) unless response_body['ok']
    end
  end
end