module Msg91sms
  require 'uri'
  require 'net/http'
  require 'json'
  class Otp
    def self.send_otp(sender, country_code, mobile, message, otp, template_id)
      mobile=country_code+mobile
      #if no otp provided use url without otp and message parameters
      url=(otp==nil)?"https://control.msg91.com/api/v5/otp?authkey=#{Msg91sms.configuration.authkey}&template_id=#{template_id}&mobile=#{mobile}&sender=#{sender}&otp_length=&otp_expiry=":"https://control.msg91.com/api/sendotp.php?authkey=#{Msg91sms.configuration.authkey}&template_id=#{template_id}&mobile=#{mobile}&&message=#{message}&otp=#{otp}&sender=#{sender}&otp_length=&otp_expiry="
      url = URI(url)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["cache-control"] = 'no-cache'
      request["content-type"] = 'application/json'
      response = http.request(request)
      JSON.parse(response.body)
    end

    def self.verify_otp(country_code, mobile, otp)
      mobile=country_code+mobile
      #if no otp provided use url without otp and message parameters
      url="https://api.msg91.com/api/v5/otp/verify?authkey=#{Msg91sms.configuration.authkey}&mobile=#{mobile}&otp=#{otp}"
      url = URI(url)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["cache-control"] = 'no-cache'

      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end