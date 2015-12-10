require 'spec_helper'

RSpec.describe Appdash::CollectPacket do

  it "should encode" do
    packet = described_class.encode Appdash::Event::Message.new("Hello world!"), Appdash::Span::ID.new
    expect(packet.bytesize).to eq(56)
  end

end
