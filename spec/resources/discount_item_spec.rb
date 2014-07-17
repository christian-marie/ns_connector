require 'spec_helper'

include NSConnector
describe DiscountItem do
	it 'should not explode on creation' do
		x = DiscountItem.new
		expect(x).to respond_to(:_class)
	end
end
