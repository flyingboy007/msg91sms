require "msg91sms/version"
require "msg91sms/configuration"
require "errors/configuration"
require "msg91sms/transactional"
require "msg91sms/otp"


module Msg91sms
  #class << self bit tells our Msg91sms module that this instance variable is on the module scope
  class << self
    attr_accessor :configuration
  end

  #Writing and reading the configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  #Resetting
  #This will reset the @configuration settings to nil if needed in future
  def self.reset
    @configuration = Configuration.new
  end

  #Passing a block to our class
  #When we call Msg91sms.configure, we pass it a block that actually creates a new instance of the Msg91sms::Configuration class using whatever we’ve set inside of the block.
  def self.configure
    yield(configuration)
  end

  class TransactionalSms
    def self.deliver(sender, country_code, mobiles, message)
      #verify mobile number manually else send error message as msg91 would
      if Msg91sms.verify_mobile?(mobiles, country_code)
        Transactional.send_transactional(sender, country_code, mobiles, message)
      else
        response = '{"message":"Please Enter valid mobile no","type":"error"}'
        JSON.parse(response)
      end
    end
  end

  class OtpSms
    def self.generate(sender, country_code, mobiles, message = nil, otp = nil, template_id)
      #verify mobile number manually else send error message as msg91 would
      if Msg91sms.verify_mobile?(country_code, mobiles)
        Otp.send_otp(sender, country_code, mobiles, message, otp, template_id)
      else
        response = '{"message":"Please Enter valid mobile no","type":"error"}'
        JSON.parse(response)
      end
    end

    def self.verification(country_code, mobile, otp)
      Otp.verify_otp(country_code, mobile, otp)
    end
  end

  #Helper method checking mobile number contains only numbers
  def self.verify_mobile?(country_code, mobile)
    if (country_code == "91")
      #currently only handles India(10 digits). For each supported country add
      min_mobile_length = 10
    else
      min_mobile_length = 0
    end
    mobile.scan(/\D/).empty? && mobile.size == min_mobile_length
  end


end
