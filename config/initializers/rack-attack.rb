class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # safelist("allow from localhost") do |req|
  #   "127.0.0.1" == req.ip || "::1" == req.ip
  # end

  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  throttle("req/post", limit: 5, period: 30.seconds) do |req|
    req.params["number"] if req.path == "/phone/new" && req.post?
  end
end
