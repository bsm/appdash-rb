require 'spec_helper'

RSpec.describe Appdash::Event::SpanName do

  subject { described_class.new "Query" }

  it "should init" do
    expect(subject.schema).to eq("name")
    expect(subject.attrs).to eq(name: "Query")
  end

  it "should annotate" do
    expect(atoh(subject.to_a)).to eq("Name" => "Query", "_schema:name" => "")
  end

end
