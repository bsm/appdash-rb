require 'appdash/event/base'

module Appdash
  module Event

    # SpanName is an event which sets a span's name.
    class SpanName < Base

      # @param [String] name the event span name
      def initialize(name)
        super("name", name: name)
      end

    end
  end
end
