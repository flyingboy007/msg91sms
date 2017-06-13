require "msg91sms/version"
require "msg91sms/configuration"
require "errors/configuration"
require "msg91sms/transactional"


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
    def self.deliver(country_code, mobiles, message, sender)
      Transactional.send_transactional(country_code, mobiles, message, sender)
    end

  end


end
