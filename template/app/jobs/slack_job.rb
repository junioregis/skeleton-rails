class SlackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    title = args.first[:title]
    message = args.first[:message]

    begin
      SlackService.new.send(title, message)
    rescue StandardError => e
      Logger.new(STDOUT).debug e
    end
  end
end
