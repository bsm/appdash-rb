require 'appdash'
require 'rack'
require 'appdash/event/rack_server'

module Appdash
  # Middleware is a rack middleware that can be used to add tracing to Rack servers.
  # It creates a span per incoming request and stores it on the 'appdash.span' key on the env.
  class Middleware
    ENV_KEY = 'appdash.span'.freeze

    def initialize(app, client)
      @app    = app
      @client = client
    end

    def call(env)
      recv = Time.now
      span = env[ENV_KEY] = @client.span

      status, headers, body = @app.call(env)
      span.event build(recv, env, status, headers)
      [status, headers, body]
    ensure
      env[ENV_KEY].flush if env.key?(ENV_KEY)
    end

    private

      def build(recv, env, status, headers)
        Appdash::Event::RackServer.new Rack::Request.new(env), nil,
          response: {
            status_code: status,
            content_length: headers['Content-Length'],
          },
          recv: recv
      end

  end
end
