require 'spec_helper'

RSpec.describe Appdash::Client do

  let(:mock_socket) { double("TCPSocket", close: nil) }
  before  { allow(TCPSocket).to receive(:new).and_return(mock_socket) }

  it "should collect spans" do
    span = subject.span
    span.event(Appdash::Event::Message.new("Hello world!"))

    expect(mock_socket).to receive(:write) do |raw|
      expect(raw.bytesize).to eq(57)
      expect(raw.bytes.first).to eq(56)
    end.and_return(57)
    span.flush
  end

  it "should support buffering" do
    subject = described_class.new(max_buffer_size: 1000)
    subject.span do |s|
      s.message("Message A")
      s.message("Message B")
    end

    expect(mock_socket).to receive(:write) do |raw|
      expect(raw.bytesize).to eq(117)
    end
    subject.close
  end

end

