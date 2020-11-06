require "spec_helper"

RSpec.describe Msg91sms do
  it "has a version number" do
    expect(Msg91sms::VERSION).not_to be nil
  end
  context "Transactional SMS", skip: true do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/transactional/invalid_mobile") do
        request = Msg91sms::TransactionalSms.deliver("RDTEST", "91", "94", "message")
        expect(request['type']).to eq('error')
      end
    end

    it "sends returns error on invalid mobile_manual verification" do
      request = Msg91sms::TransactionalSms.deliver("RDTEST", "91", "hdhdhdhdhhd", "message")
      expect(request['type']).to eq('error')
    end


    it "returns success if successful" do
      VCR.use_cassette("msg91/transactional/success") do
        request = Msg91sms::TransactionalSms.deliver("RDTEST", "91", "9446716017", "message")
        expect(request['type']).to eq('success')
      end
    end
  end

=begin
  context "custom Otp Sms", skip: true do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/custom_otp/invalid_mobile") do
        request=Msg91sms::OtpSms.generate("RDTEST", "94", "94", "Your otp is 2222", "2222")
        expect(request['type']).to eq('error')
      end
    end

    it "sends returns error on invalid mobile manual verification" do
        request=Msg91sms::OtpSms.generate("RDTEST", "94", "jdjdjdjjdjdjd", "Your otp is 2222", "2222")
        expect(request['type']).to eq('error')
    end

    it "returns success if successful" do
      VCR.use_cassette("msg91/custom_otp/success") do
        request=Msg91sms::OtpSms.generate("RDTEST", "91", "9446716017", "Your otp is 2222", "2222")
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
=end

  context "Normal Otp Sms" do
    it "sends returns error on invalid mobile" do
      VCR.use_cassette("msg91/normal_otp/invalid_mobile") do
        request = Msg91sms::OtpSms.generate(country_code: "94", mobile: "94", template_id: "5fa3a76155f33b28127ce2ed")
        expect(request['type']).to eq('error')
      end
    end

    it "sends returns error on invalid mobile manual verification" do
      request = Msg91sms::OtpSms.generate(country_code: "94", mobile: "djdjjdjdjd", template_id: "5fa3a76155f33b28127ce2ed")
      expect(request['type']).to eq('error')
    end

    it "returns success if successful" do
      VCR.use_cassette("msg91/normal_otp/success") do
        request = Msg91sms::OtpSms.generate(country_code: "91", mobile: "9446716017", template_id: "5fa3a76155f33b28127ce2ed", otp_length: 5, otp_expiry: 15)
        expect(request['type']).to eq('success')
      end
    end
  end

  context "Verify Otp Sms" do
    it "sends returns error on invalid otp" do
      VCR.use_cassette("msg91/normal_otp/verification/invalid_mobile") do
        request = Msg91sms::OtpSms.verification(country_code: "91", mobile: "9446716017", otp: "5580")
        expect(request['type']).to eq('error')
      end
    end

    it "sends returns error on invalid mobile manual verification" do
      VCR.use_cassette("msg91/normal_otp/verification/invalid_mobile_manual") do
        request = Msg91sms::OtpSms.verification(country_code: "91", mobile: "djdjjdjdjd", otp: "2222")
        expect(request['type']).to eq('error')
      end
    end

    it "returns success if successful" do
      VCR.use_cassette("msg91/normal_otp/verification/success") do
        request = Msg91sms::OtpSms.verification(country_code: "91", mobile: "9446716017", otp: "65647")
        expect(request['type']).to eq('success')
      end
    end
  end
end
