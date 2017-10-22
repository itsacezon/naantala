# From https://semaphore.co/docs. Thanks to Chowpocket!

class SemaphoreApi
  class << self
    def send_message(message: nil, number: nil)
      return if message.nil? or number.nil?

      uri = Addressable::URI.new

      options = {
        apikey: ENV["SEMAPHORE_API_KEY"],
        number: number,
        message: message,
        sendername: ENV["SEMAPHORE_SENDER_NAME"]
      }

      uri.query_values = options
      path = "http://api.semaphore.co/api/v4/messages?#{uri.query}"
      response = HTTP.post(path)

      JSON.parse(response).group_by { |r| r["status"].downcase }
    end
  end
end
