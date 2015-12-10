require 'protobuf'
require 'appdash/collector.pb.rb'

module Appdash
  class CollectPacket

    def self.encode(event, id)
      wired = SpanID.new(trace: id.trace, span: id.span, parent: id.parent)
      new(spanid: wired, annotation: event.to_a).encode
    end

  end
end
