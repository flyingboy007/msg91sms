require "spec_helper"

RSpec.describe Msg91sms do
  it "has a version number" do
    expect(Msg91sms::VERSION).not_to be nil
  end
  context "Transactional SMS" do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/transactional/invalid_mobile") do
        request=Msg91sms::TransactionalSms.deliver("RDTEST","91", "94", "message")
        expect(request['type']).to eq('error')
      end
    end


    it "returns success if successful" do
      VCR.use_cassette("msg91/transactional/success") do
        request=Msg91sms::TransactionalSms.deliver("RDTEST", "91", "9446716017", "message")
        expect(request['type']).to eq('success')
      end
    end
  end

  context "custom Otp Sms" do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/custom_otp/invalid_mobile") do
        request=Msg91sms::OtpSms.generate("RDTEST", "94", "94", "Your otp is 2222", "2222")
        expect(request['type']).to eq('error')
      end
    end

    it "returns success if successful" do
      VCR.use_cassette("msg91/custom_otp/success") do
        request=Msg91sms::OtpSms.generate("RDTEST", "91", "8553445441", "Your otp is 2222", "2222")
        expect(request['type']).to eq('success')
      end
    end

    it "verifies valid otp" do
      VCR.use_cassette("msg91/custom_otp/verify/success") do
        request=Msg91sms::OtpSms.verification("91", "8553445441", "2222")
        expect(request['type']).to eq('success')
      end
    end

    it "error invalid otp" do
      VCR.use_cassette("msg91/custom_otp/verify/invalid_otp") do
        request=Msg91sms::OtpSms.verification("91", "8553445441", "2252")
        expect(request['type']).to eq('error')
      end
    end
  end

  context "Normal Otp Sms" do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/normal_otp/invalid_mobile") do
        request=Msg91sms::OtpSms.generate("RDTEST", "94", "94")
        expect(request['type']).to eq('error')
      end
    end

    it "returns success if successful" do
      VCR.use_cassette("msg91/normal_otp/success") do
        request=Msg91sms::OtpSms.generate("RDTEST", "91", "8553445441")
        expect(request['type']).to eq('success')
      end
    end
  end
end
