require 'rspec'
require 'rack'
require 'appdash'

helpers = Module.new do

  def atoh(annotations)
    annotations.inject({}) {|h, a| h[a.key] = a.value; h }
  end

end

RSpec.configure do |c|
  c.include helpers
end
