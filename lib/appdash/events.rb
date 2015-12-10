require 'appdash/event/base'
require 'appdash/event/span_name'
require 'appdash/event/message'
require 'appdash/event/log'
require 'appdash/event/rack_server'

module Appdash
  module Event

    # @return [Hash] known acronyms for attribute translations
    def self.acronyms
      @acronyms ||= {
        "url" => "URL",
        "uri" => "URI",
        "id"  => "ID",
        "ip"  => "IP",
      }
    end

  end
end
