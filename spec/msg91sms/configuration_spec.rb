require_relative '../spec_helper'

describe Msg91sms::Configuration do
  context 'with configuration block' do
    it 'returns the correct authkey' do
      expect(Msg91sms.configuration.authkey).to eq(ENV['MSG91_AUTHKEY'])
    end
  end

  context '#reset' do
    it 'resets configured values' do
      expect(Msg91sms.configuration.authkey).to eq(ENV['MSG91_AUTHKEY'])

      Msg91sms.reset
      expect { Msg91sms.configuration.authkey }.to raise_error(Msg91sms::Errors::Configuration)
    end
  end

  context 'without configuration block' do
    before do
      Msg91sms.reset
    end

    it 'raises a configuration error for authkey' do
      expect { Msg91sms.configuration.authkey }.to raise_error(Msg91sms::Errors::Configuration)
    end
  end


end