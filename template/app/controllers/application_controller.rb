class ApplicationController < ActionController::API
  rescue_from StandardError, with: :internal_error

  def internal_error(e)
    log e
    r message: 'error.internal_error', status: 500
  end

  def routing_error
    r message: 'error.routing_error', status: 404
  end

  def bad_credentials
    r message: 'auth.bad_credentials', status: 404
  end

  def unauthorized
    r message: 'auth.unauthorized', status: 404
  end

  protected

  def log(e)
    title = e.message

    message = if e.is_a? Exception
                project_files = Dir.glob("**/*").select { |f| File.file?(f) }

                e.backtrace.select { |line| project_files.any? { |p| line.include? p } }.each { |line| logger.debug line }
              else
                e
              end.join("\n")

    logger.debug "#{title}: #{message}"

    Thread.new do
      Slack::send(title, message)
    rescue StandardError => e
      logger.debug e
    end
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

    body = { meta: { code:    options[:status],
                     message: options[:message] },
             result: options[:body]}

    options[:headers].each { |k, v| response[k.to_s] = v }

    render json: body, status: options[:status]
  end

  alias r render_response
end
