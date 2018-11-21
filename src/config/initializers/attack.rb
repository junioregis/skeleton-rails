class Rack::Attack
  Rack::Attack.safelist("localhost") { |req| req.ip == "127.0.0.1" }
  
  throttle('req/ip', limit: 5, period: 10.seconds) do |req|
    req.ip
  end
end
