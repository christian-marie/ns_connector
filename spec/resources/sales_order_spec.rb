require 'spec_helper'

include NSConnector
describe SalesOrder do
	it 'should not explode on creation' do
		x = SalesOrder.new
		expect(x).to respond_to(:_class)
	end
end
