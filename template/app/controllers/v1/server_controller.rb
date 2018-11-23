module V1
  class ServerController < ApiController
    def ping
      r message: 'server.pong', status: 200
    end
  end
end
