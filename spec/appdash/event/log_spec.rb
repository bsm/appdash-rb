require 'spec_helper'

RSpec.describe Appdash::Event::Log do

  let(:time) { Time.utc(2001,2,3,4,5,6) }
  before     { allow(Time).to receive(:now).and_return(time) }
  subject    { described_class.new "Hi" }

  it "should init" do
    expect(subject.schema).to eq("log")
    expect(subject.attrs).to eq(msg: "Hi", time: time)
  end

  it "should annotate" do
    expect(atoh(subject.to_a)).to eq(
      "Msg" => "Hi",
      "Time" => "2001-02-03T04:05:06+00:00",
      "_schema:log" => "",
    )
  end

end
