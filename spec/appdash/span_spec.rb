require 'spec_helper'

RSpec.describe Appdash::Span do

  let(:mock_client) { double("Client", write: nil) }
  subject { described_class.new mock_client }

  it "should append events" do
    expect(subject.id).to eq(subject.root_id)
    subject.name("test")
    expect(subject.id).not_to eq(subject.root_id)
    expect(subject.id.to_s.size).to eq(50)

    subject.message("test message")
    subject.log("test log")
    expect(subject.instance_variable_get(:@packets).size).to eq(3)
  end

  it "should flush" do
    expect(subject.flush).to eq(0)

    subject.name("test")
    subject.message("test message")

    expect(mock_client).to receive(:write) do |packets|
      expect(packets.size).to eq(2)
      expect(packets[0].annotation.map(&:to_hash)).to eq([{key: "Name", value: "test"}, {key: "_schema:name"}])
      expect(packets[1].annotation.map(&:to_hash)).to eq([{key: "Msg", value: "test message"}, {key: "_schema:msg"}])
    end
    expect(subject.flush).to eq(2)
  end

end
