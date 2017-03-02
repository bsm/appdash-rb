require 'rspec'
require 'rack'
require 'rack/test'
require 'appdash'
require 'appdash/middleware'

helpers = Module.new do
  def atoh(annotations)
    annotations.inject({}) {|h, a| h[a.key] = a.value; h }
  end

  def mock_span_id
    id = Appdash::Span::ID.new
    id.instance_variable_set(:@span, 1234)
    id.instance_variable_set(:@trace, 5678)
    id
  end

end

RSpec.configure do |c|
  c.include helpers
end
