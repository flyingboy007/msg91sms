module Msg91sms
  require 'uri'
  require 'net/http'
  require 'json'
  class Otp
    def self.send_otp(sender, country_code, mobiles, message, otp)
      require 'uri'
      require 'net/http'
      mobile=country_code+mobiles
      #if no otp provided use url without otp and message parameters
      url=(otp==nil)?"https://control.msg91.com/api/sendotp.php?authkey=#{Msg91sms.configuration.authkey}&mobile=#{mobile}&sender=#{sender}":"https://control.msg91.com/api/sendotp.php?authkey=#{Msg91sms.configuration.authkey}&mobile=#{mobile}&&message=#{message}&otp=#{otp}&sender=#{sender}"
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