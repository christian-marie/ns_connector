require 'spec_helper'

include NSConnector
describe Customer do
	it 'should not explode on creation' do
		Customer.new
	end
end
