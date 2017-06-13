module Msg91sms
  require 'uri'
  require 'net/http'
  require 'json'
  class Transactional
    def self.send_transactional(sender, country_code, mobiles, message)
    url = URI("https://control.msg91.com/api/sendhttp.php?authkey=#{ENV['MSG91_AUTHKEY']}&mobiles=#{mobiles}&message=#{message}&sender=#{sender}&route=4&country=#{country_code}&response=json")

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