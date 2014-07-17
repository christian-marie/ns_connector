require 'spec_helper'

include NSConnector
describe CustomerDeposit do
	it 'should not explode on creation' do
		x = CustomerDeposit.new
		expect(x).to respond_to(:_class)
	end
end
