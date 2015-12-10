require 'spec_helper'

RSpec.describe Appdash::Middleware do
  include Rack::Test::Methods

  let(:mock_socket) { double("TCPSocket", shutdown: nil) }
  before            { allow(TCPSocket).to receive(:new).and_return(mock_socket) }

  let(:app) do
    mware  = described_class
    client = Appdash::Client.new

    Rack::Builder.new do
      use mware, client
      run ->_ { [200, {'Content-Type' => 'text/plain'}, ["OK"]] }
    end
  end

  it 'should trace requests' do
    expect(mock_socket).to receive(:write) do |msg|
      expect(msg.size).to eq(406)
    end
    get '/'
    expect(last_response.status).to eq(200)
  end

end
