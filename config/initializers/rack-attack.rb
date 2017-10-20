class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist("allow from localhost") do |req|
    "127.0.0.1" == req.ip || "::1" == req.ip
  end

  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  throttle("post/ip", limit: 5, period: 30.seconds) do |req|
    if req.path == "/phone/new" && req.post?
      req.ip
    elsif req.path == "/phone/confirm" && req.get?
      req.ip
    end
  end

  throttle("post/phone", limit: 5, period: 30.seconds) do |req|
    if req.path == "/phone/new" && req.post?
      req.params["number"]
    elsif req.path == "/phone/confirm" && req.get?
      req.params["code"]
    end
  end
end
