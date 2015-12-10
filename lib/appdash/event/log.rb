require 'appdash/event/base'
require 'time'

module Appdash
  module Event

    # Log is an event whose timestamp is the current time and contains the given human-readable log message.
    class Log < Base

      # @param [String] msg the log message
      def initialize(msg)
        super("log", msg: msg, time: Time.now)
      end

    end
  end
end
