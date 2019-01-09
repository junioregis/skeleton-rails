class ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!

  rescue_from StandardError, with: :internal_error

  def internal_error(e)
    Log.error e
    r message: 'error.internal_error', status: 500
  end

  def routing_error
    r message: 'error.routing_error', status: 404
  end

  protected

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def set_locale(locale)
    I18n.locale = locale || I18n.default_locale
  end

  def render_response(options = {})
    default = {
        message: '',
        headers: {},
        body: {},
        status: 200
    }

    options = default.merge options

    options[:message] = I18n.t("response.#{options[:message]}") unless options[:message].empty?

    body = {meta: {code: options[:status],
                   message: options[:message]},
            result: options[:body]}

    options[:headers].each {|k, v| response[k.to_s] = v}

    render json: body, status: options[:status].to_i
  end

  alias r render_response
end
