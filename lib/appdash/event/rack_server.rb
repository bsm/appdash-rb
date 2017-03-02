require 'appdash/event/base'

module Appdash
  module Event

    # RackServer represents a HTTP event where a client's request was served via Rack.
    class RackServer < Base

      # @param [Rack::Request] req a Rack request object
      # @param [Rack::Response] resp an optional Rack response object
      # @param [Hash] attrs additional attributes, e.g. :user or :route
      def initialize(req, resp = nil, attrs = {})
        server = attrs.dup
        server[:send] ||= Time.now
        server[:request] ||= {}
        server[:request].update parse_request(req)
        if resp
          server[:response] ||= {}
          server[:response].update parse_response(resp)
        end

        super("HTTPServer", server: server)
      end

      protected

        def parse_request(req)
          data = {
            method: req.request_method,
            path: req.fullpath,
            scheme: req.scheme,
            host: req.host,
            remote_ip: req.ip,
            content_length: req.content_length
          }

          [:content_type, :user_agent].each do |name|
            value = req.send(name)
            data[name] = value if value
          end

          data
        end

        def parse_response(resp)
          {
            content_length: resp.content_length,
            status_code: resp.status
          }
        end

    end
  end
end
