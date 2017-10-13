module Naantala
  module Service
    class Notifier
      attr_reader :numbers

      def initialize(params = {})
        @numbers = params.fetch(:numbers, [])
      end
    end
  end
end
