require "spec_helper"

RSpec.describe Msg91sms do
  it "has a version number" do
    expect(Msg91sms::VERSION).not_to be nil
  end

  it "does something useful" do
    #expect(false).to eq(true)
  end

  it "sends returns error on invalid mobile" do
    VCR.use_cassette("msg91/transactional/invalid_mobile") do
      request=Msg91sms::TransactionalSms.deliver("91", "94", "message", "RDTEST")
      expect(request['type']).to eq('error')
    end

  end


  it "returns success if successful" do
    VCR.use_cassette("msg91/transactional/success") do
      request=Msg91sms::TransactionalSms.deliver("RDTEST", "91", "9446716017g", "message")
      expect(request['type']).to eq('success')
      puts request
    end
  end
end
