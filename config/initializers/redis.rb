# frozen_string_literal: true

# RabbitMQ singleton
class PandaRedis
  class << self
    def client
      @client ||= Redis.new(
        host: Yetting.redis['url'],
        password: Yetting.redis['password'],
        port: 6379,
        db: 0
      )
    end
  end
end
