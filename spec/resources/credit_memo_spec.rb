require 'spec_helper'

include NSConnector
describe CreditMemo do
	it 'should not explode on creation' do
		x = CreditMemo.new
		expect(x).to respond_to(:_class)
	end
end
