module Log
  LOGGER = Logger.new(STDOUT)

  def self.debug(msg)
    print :debug, msg
  end

  def self.success(msg)
    print :success, msg
  end

  def self.error(msg)
    project_files = Dir.glob("**/*").select {|f| File.file?(f)}

    print :error, msg

    if msg.is_a? Exception
      msg.backtrace.select {|line| project_files.any? {|p| line.include? p}}.each {|line| print(:error, line)}
    end

    # TODO: Slack

    #Thread.new do
    #  SlackService::send(title, message)
    #rescue StandardError => e
    #  logger.debug e
    #end
  end

  private

  def self.print(type, msg)
    color = case (type)
            when :debug then
              :blue
            when :success then
              :green
            when :error then
              :red
            else
              :black
            end

    output = ActiveSupport::LogSubscriber.new.send(:color, msg, color)

    case (type)
    when :error then
      LOGGER.error output
    else
      LOGGER.debug output
    end
  end
end