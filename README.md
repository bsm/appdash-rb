Ruby Appdash
============

[Appdash](https://github.com/sourcegraph/appdash) client for Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'appdash'

Or install:

    $ gem install appdash

Connect to an instance:

    client = Appdash::Client.new host: "remote.host", port: 7701, max_buffer_size: 20

Collect spans:

    client.span do |s|
      s.name "Request"
      s.log "a log entry with a timestamp"
    end

Rack middleware:

    require 'sinatra'
    require 'appdash/middleware'

    client = Appdash::Client.new host: "remote.host", port: 7701
    use Appdash::Middleware, client

    get '/' do
      "OK"
    end

For full options and event types, please see the [Documentation](http://www.rubydoc.info/gems/appdash).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make a pull request
