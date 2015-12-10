require 'appdash/wire'

module Appdash
  module Event

    # Base forms the most basic event type
    class Base

      attr_reader :schema, :attrs

      # @param [String] schema the event schema name
      # @param [Hash] attrs event attributes
      def initialize(schema, attrs = {})
        super()
        @schema = schema
        @attrs = attrs
      end

      # @return [Array<Appdash::CollectPacket::Annotation>] marshalable annotations
      def to_a
        annotate(attrs) + [annotation(['_schema', schema].join(':'))]
      end

      protected

        def annotate(hash, prefix = nil)
          hash.map do |key, value|
            key = [prefix, normalize(key)].compact.join('.')

            case value
            when Hash
              annotate(value, key)
            else
              annotation(key, value)
            end
          end.flatten
        end

        def annotation(key, value = nil)
          case value
          when DateTime, Time
            value = value.strftime('%FT%T%:z')
          when NilClass
            # ignore
          else
            value = value.to_s
          end
          Appdash::CollectPacket::Annotation.new(key: key, value: value)
        end

        def normalize(key)
          key = key.to_s
          key = key.sub(/^[a-z\d]*/) { Appdash::Event.acronyms[$&] || $&.capitalize }
          key.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{Appdash::Event.acronyms[$2] || $2.capitalize}" }

          key[0] = key[0].upcase if key.size > 0
          key
        end

    end
  end
end
