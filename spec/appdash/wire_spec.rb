require 'spec_helper'

RSpec.describe Appdash::CollectPacket do

  it "should build" do
    packet = described_class.build Appdash::Event::Message.new("Hello world!"), mock_span_id
    expect(packet).to be_instance_of(described_class)
    expect(packet.to_hash).to eq(
      spanid: {
        trace: 5678,
        span:  1234,
      },
      annotation: [
        {key: "Msg", value: "Hello world!"},
        {key: "_schema:msg"},
      ]
    )
  end

end
