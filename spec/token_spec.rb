require 'spec_helper'

RSpec.describe Hello do
  let(:url) {"https://accounts.secure.freee.co.jp/public_api/token"}
  let(:params) {}
  it "message return hello" do
    expect(Hello.new.message).to eq "hello"
  end
end
