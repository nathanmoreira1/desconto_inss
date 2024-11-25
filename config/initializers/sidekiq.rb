Sidekiq.configure_server do |config|
    config.redis = {
        host: ENV["REDIS_HOST"],
        port: ENV["REDIS_PORT"] || "6379",
        namespace: "myapp_sidekiq"
    }
end

Sidekiq.configure_client do |config|
    config.redis = {
        host: ENV["REDIS_HOST"],
        port: ENV["REDIS_PORT"] || "6379",
        namespace: "myapp_sidekiq"
    }
end
