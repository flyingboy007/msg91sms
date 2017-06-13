require "bundler/setup"
require "msg91sms"
require "support/vcr_setup"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  #For adding auth key
  config.before(:all) do
    Msg91sms.configure do |config|
      config.authkey = ENV['MSG91_AUTHKEY']
    end
  end

  #for mocking external services requests
  require 'webmock/rspec'
  WebMock.disable_net_connect!(allow_localhost: true)


end
