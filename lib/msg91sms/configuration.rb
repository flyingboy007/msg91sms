module Msg91sms
  class Configuration
    attr_accessor :authkey

    def initialize
      @authkey = nil
    end

    def authkey
      raise Msg91sms::Errors::Configuration, "Msg91 auth key missing!" unless @authkey
      @authkey
    end
  end
end