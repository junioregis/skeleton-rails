class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    begin
      request.headers.fetch('Api-Version') == version.to_s
    rescue Exception
      # TODO: log
      false
    end
  end
end