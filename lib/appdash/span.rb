require 'appdash/span/id'

module Appdash
  class Span

    # @attr_reader :root_id returns the root span ID
    attr_reader :root_id

    # @attr_reader :id returns the current span ID
    attr_reader :id

    def initialize(client)
      @client  = client
      @packets = []
      @root_id = Appdash::Span::ID.new
      @id      = root_id
    end

    # Appends a new Appdash::Event::SpanName event
    def name(val)
      event Appdash::Event::SpanName.new(val)
    end

    # Appends a new Appdash::Event::Message event
    def message(msg)
      event Appdash::Event::Message.new(msg)
    end

    # Appends a new Appdash::Event::Log event
    def log(msg)
      event Appdash::Event::Log.new(msg)
    end

    # Appends a generic Appdash::Event event
    def event(evt)
      @packets.push Appdash::CollectPacket.encode(evt, @id)
      @id = @id.child
    end

    def flush
      count = @packets.size
      @client.send :write, @packets
      @packets.clear
      count
    end

  end
end
