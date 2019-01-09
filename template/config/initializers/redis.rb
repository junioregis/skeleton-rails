case Rails.env
when 'test'
  $redis = Redis.new(url: ENV["REDIS_URL"])
else
  $redis = Redis.new(host: "redis", port: 6379)
end
