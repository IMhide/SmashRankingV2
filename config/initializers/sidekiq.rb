if Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.fake!
else
  Sidekiq.configure_server do |config|
    config.redis = { url: "#{ENV.fetch('REDIS_URL')}/#{ENV.fetch('REDIS_DB')}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "#{ENV.fetch('REDIS_URL')}/#{ENV.fetch('REDIS_DB')}" }
  end
end
