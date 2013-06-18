require 'spec_helper'

include NSConnector
describe CustomerPayment do
	it 'should not explode on creation' do
		CustomerPayment.new
	end
end
