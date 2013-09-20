$: << File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.join(File.dirname(__FILE__))

require 'pry'
require 'pp'
require 'rspec'
require 'webmock/rspec'
require 'ns_connector'
require 'support/mock_data'

require 'coveralls'
Coveralls.wear!


RSpec.configure do |config|
	config.order = "random"
	config.color_enabled = true
end

