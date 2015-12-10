require 'socket'
require 'thread'

module Appdash
  class Client

    # Client defaults
    DEFAULTS = {
      host: 'localhost',
      port: 7701,
      max_buffer_size: 1,
    }.freeze

    # Initializes a new client
    # @param [Hash] opts
    # @option opts [String] :host the hostname, defaults to localhost
    # @option opts [Integer] :port the port, defaults to 7701
    # @option opts [Integer] :max_buffer_size number of spans in the buffer before flushing, defaults to 1 (= no buffering)
    def initialize(opts = {})
      @config = DEFAULTS.merge(opts)
      @sock   = TCPSocket.new @config[:host], @config[:port]
      @buffer = []
      @mutex  = Mutex.new
    end

    # Traces a new span with a series of associated events. Accepts an optional block. If no block is given you must flush
    # to send data to the collector.
    #
    # @example manual flush
    #
    #   span = client.span
    #   span.name "Request"
    #   span.message "A simple message"
    #   span.flush
    #
    # @example with block
    #
    #   client.span do |span|
    #     span.name "Request"
    #     span.message "A simple message"
    #   end
    def span(&block)
      span = Appdash::Span.new(self)
      return span unless block

      begin
        block.call(span)
      ensure
        span.flush
      end
    end

    # Shutdown flushes any remaining buffered packets and closes the connection
    def shutdown
      flush_buffer!
      @sock.shutdown
    end

    private

      def write(packets)
        packets.each do |packet|
          raw = Protobuf::Field::VarintField.encode(packet.bytesize)+packet
          @buffer.push(raw)
        end
        flush_buffer! unless @buffer.size < @config[:max_buffer_size]
      end

      def flush_buffer!
        @mutex.synchronize do
          @sock.write @buffer.join("\n") unless @buffer.empty?
          @buffer.clear
        end
      end

  end
end
