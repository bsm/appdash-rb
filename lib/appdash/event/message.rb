require 'appdash/event/base'

module Appdash
  module Event

    # Message is an event that contains only a human-readable message.
    class Message < Base

      # @param [String] msg the message
      def initialize(msg)
        super("msg", msg: msg)
      end

    end
  end
end
