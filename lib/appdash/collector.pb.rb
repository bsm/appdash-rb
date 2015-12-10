# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module Appdash

  ##
  # Message Classes
  #
  class CollectPacket < ::Protobuf::Message
    class SpanID < ::Protobuf::Message; end
    class Annotation < ::Protobuf::Message; end

  end



  ##
  # Message Fields
  #
  class CollectPacket
    class SpanID
      required :fixed64, :trace, 2
      required :fixed64, :span, 3
      optional :fixed64, :parent, 4
    end

    class Annotation
      required :string, :key, 6
      optional :bytes, :value, 7
    end

    required ::Appdash::CollectPacket::SpanID, :spanid, 1
    repeated ::Appdash::CollectPacket::Annotation, :annotation, 5
  end

end

