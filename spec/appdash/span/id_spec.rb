require 'spec_helper'

RSpec.describe Appdash::Span::ID do

  before do
    allow(SecureRandom).to receive(:random_bytes).with(8).
      and_return("A~CDEF~H", "xyz\x00\x00\x00\x00\x00", "^&<>^*%!", "2531afas", "*&^%$-[]")
  end

  it "should create instances" do
    expect(subject.trace).to eq(5223689881108315713)
    expect(subject.span).to eq(8026488)
    expect(subject.parent).to be_nil
    expect(subject.to_s).to eq("487e464544437e41/00000000007a7978")
  end

  it "should create children" do
    child = subject.child
    expect(child.trace).to eq(5223689881108315713)
    expect(child.span).to eq(2388361761649337950)
    expect(child.parent).to eq(8026488)
    expect(child.to_s).to eq("487e464544437e41/21252a5e3e3c265e/00000000007a7978")
  end

end
