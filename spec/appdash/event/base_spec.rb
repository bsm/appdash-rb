require 'spec_helper'

RSpec.describe Appdash::Event::Base do

  subject { described_class.new 'test', name: "Query", some_other: 2, sub: { req_url: "http://example.com/path", nest: { v: Time.utc(2015) }}}

  it "should init" do
    expect(subject.schema).to eq("test")
    expect(subject.attrs.size).to eq(3)
  end

  it "should annotate" do
    expect(atoh(subject.to_a)).to eq(
      "Name" => "Query",
      "SomeOther" => "2",
      "Sub.ReqURL" => "http://example.com/path",
      "Sub.Nest.V"=>"2015-01-01T00:00:00.000000+00:00",
      "_schema:test"=>"",
    )
  end

end
