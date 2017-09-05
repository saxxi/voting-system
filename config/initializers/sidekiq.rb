redis_host = ENV['REDIS_HOST'] || 'redis://127.0.0.1:6379'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_host }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_host }
end
