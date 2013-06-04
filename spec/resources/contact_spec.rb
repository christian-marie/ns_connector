require 'spec_helper'

include NSConnector
describe Contact do
	it 'should not explode on creation' do
		Contact.new
	end
end
