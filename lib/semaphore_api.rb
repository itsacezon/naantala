# From https://semaphore.co/docs. Thanks to Chowpocket!

class SemaphoreApi
  def initialize
    @api_key = ENV["SEMAPHORE_API_KEY"]
    @sender_name = ENV["SEMAPHORE_SENDER_NAME"]
  end

  def send_message(message: nil, number: nil)
    return if message.nil? or number.nil?

    uri = Addressable::URI.new

    options = {
      apikey: @api_key,
      number: numbers,
      message: message,
      sendername: @sender_name
    }

    uri.query_values = options
    path = "http://api.semaphore.co/api/v4/messages?#{uri.query}"
    response = HTTP.post(path)

    JSON.parse(response).group_by { |r| r["status"].downcase }
  end
end
