require 'stringio'

module Appdash
  class Buffer < ::StringIO

    def initialize
      super
      binmode
    end

    def push(packet)
      payload = packet.serialize_to_string
      write_uvarint payload.bytesize
      write payload
    end

    def bytesize
      string.bytesize
    end

    def reset
      truncate(0)
      rewind
    end

    private

      def write_uvarint(x)
        while x >= 0x80
          write ((x & 0xFF) | 0x80).chr
          x >>= 7
        end
        write (x & 0xFF).chr
      end

  end
end
