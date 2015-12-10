require 'spec_helper'

RSpec.describe Appdash::Event::Message do

  subject { described_class.new "Hi" }

  it "should init" do
    expect(subject.schema).to eq("msg")
    expect(subject.attrs).to eq(msg: "Hi")
  end

  it "should annotate" do
    expect(atoh(subject.to_a)).to eq("Msg"=>"Hi", "_schema:msg"=>"")
  end

end
