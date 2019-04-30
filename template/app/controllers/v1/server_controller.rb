module V1
  class ServerController < ApiController
    skip_before_action :doorkeeper_authorize!, only: [:ping]

    def ping
      r message: 'server.pong', status: 200
    end
  end
end
