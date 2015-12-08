require 'spec_helper'
describe NSConnector::Config do
	before(:each) do
		# Reset our 'global' config
		# Yes, it's kinda not nice to have a global configuration like
		# this, but it's better than passing the damned thing around
		# everywhere. Thread safety should be fine for reads.
		NSConnector::Config.set_config!({})
	end

	it 'sets a valid config' do
		NSConnector::Config.set_config!(valid_config)
		expect(NSConnector::Config.check_valid!).to be true
	end

	it 'sets an invalid config' do
		NSConnector::Config.set_config!(:invalid => true)
		expect{NSConnector::Config.check_valid!}.to raise_error
	end

	it 'allows reading of keys' do
		expect(NSConnector::Config[:account_id]).to be_nil

		NSConnector::Config.set_config!(valid_config)

		expect(NSConnector::Config[:account_id]).to eql('account_id')
		expect(NSConnector::Config['account_id']).to eql('account_id')
	end

	it 'allows writing of keys' do
		expect(NSConnector::Config[:account_id]).to be_nil
		NSConnector::Config[:account_id] = 'account_id'
		expect(NSConnector::Config[:account_id]).to eql('account_id')

		NSConnector::Config['account_id'] = nil
		expect(NSConnector::Config[:account_id]).to be_nil
	end

	it 'has defaults' do
		expect(NSConnector::Config['use_threads']).
			to eql(!!NSConnector::Config['use_threads'])
	end
end
