require 'spec_helper'

include NSConnector
describe NonInventoryItem do
	it 'should not explode on creation' do
		x = NonInventoryItem.new
		expect(x).to respond_to(:_class)
	end
end
