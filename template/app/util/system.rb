module System
  module Redis
    def self.exists?(key)
      $redis.hexists(:system, key)
    end

    def self.set(key, value)
      $redis.hset(:system, key, Marshal.dump(value))
    end

    def self.get(key)
      value = $redis.hget(:system, key)

      Marshal.load(value) rescue nil
    end
  end
end