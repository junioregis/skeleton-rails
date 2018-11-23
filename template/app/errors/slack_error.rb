class SlackError < StandardError
  def initialize(e = 'Slack error')
    super(e)
  end
end