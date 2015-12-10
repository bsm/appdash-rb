require 'securerandom'

module Appdash
  class Span

    class ID
      # @attr_reader [Integer] root ID of the tree that contains all of the spans related to this one.
      attr_reader :trace

      # @attr_reader [Integer] an ID that probabilistically uniquely identifies this span.
      attr_reader :span

      # @attr_reader [Integer] the ID of the parent span, if any.
      attr_reader :parent

      # Creates a new root span
      # @param [Appdash::SpanID] parent, optional parent
      def initialize(parent = nil)
        @trace  = parent ? parent.trace : random_uint64
        @span   = random_uint64
        @parent = parent.span if parent
      end

      # @return [Appdash::SpanID] creates a child span
      def child
        self.class.new(self)
      end

      # @return [String] string ID
      def to_s
        [trace, span, parent].compact.map do |num|
          num.to_s(16).rjust(16, '0')
        end.join("/")
      end

      private

        def random_uint64
          SecureRandom.random_bytes(8).unpack("Q")[0]
        end

    end
  end
end
