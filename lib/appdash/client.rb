require 'socket'
require 'thread'
require 'appdash/buffer'

module Appdash
  class Client

    # Client defaults
    DEFAULTS = {
      host: 'localhost',
      port: 7701,
      max_buffer_size: 0,
    }.freeze

    # Initializes a new client
    # @param [Hash] opts
    # @option opts [String] :host the hostname, defaults to localhost
    # @option opts [Integer] :port the port, defaults to 7701
    # @option opts [Integer] :max_buffer_size maximum buffer size in bytes, defaults to 0 (= no buffering, flushes on every span)
    def initialize(opts = {})
      @config = DEFAULTS.merge(opts)
      @buffer = Buffer.new
      @mutex  = Mutex.new
      reconnect!
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

    # Close flushes any remaining buffered packets and closes the connection
    def close
      flush_buffer!
      @sock.close
    end

    private

      def write(packets)
        packets.each do |packet|
          @buffer.push(packet)
        end
        flush_buffer! if @buffer.bytesize > @config[:max_buffer_size]
      end

      def flush_buffer!
        with_reconnect do
          @mutex.synchronize do
            @sock.write @buffer.string unless @buffer.bytesize.zero?
            @buffer.reset
          end
        end
      end

      def reconnect!
        @sock.close if @sock
        @sock = TCPSocket.new @config[:host], @config[:port]
      end

      def with_reconnect(attempt = 0, &block)
        yield
      rescue Errno::EPIPE
        raise if attempt > 1
        reconnect!
        with_reconnect(attempt+1, &block)
      end

  end
end
