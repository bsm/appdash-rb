require 'spec_helper'

RSpec.describe Appdash::Event::RackServer do

  let(:time)     { Time.utc(2001,2,3,4,5,6) }
  let(:response) { Rack::Response.new([], 201, 'Content-Length' => 33) }
  let(:request) do
    env = Rack::MockRequest.env_for("http://example.com:8080/", "REMOTE_ADDR" => "10.10.10.10", 'CONTENT_LENGTH' => 12, 'HTTP_USER_AGENT' => 'Test/1.0')
    Rack::Request.new(env)
  end

  before  { allow(Time).to receive(:now).and_return(time) }
  subject { described_class.new request, response, route: 'createPost' }

  it "should init" do
    expect(subject.schema).to eq("HTTPServer")
    expect(subject.attrs.size).to eq(1)
  end

  it "should annotate" do
    expect(atoh(subject.to_a)).to eq(
      "Server.Request.ContentLength" => "12",
      "Server.Request.Host" => "example.com",
      "Server.Request.Method" => "GET",
      "Server.Request.Scheme" => "http",
      "Server.Request.RemoteIP" => "10.10.10.10",
      "Server.Request.URL" => "http://example.com:8080/",
      "Server.Request.UserAgent" => "Test/1.0",
      "Server.Response.ContentLength" => "0",
      "Server.Response.StatusCode" => "201",
      "Server.Route" => "createPost",
      "Server.Send" => "2001-02-03T04:05:06+00:00",
      "_schema:HTTPServer" => "",
    )
  end

end
