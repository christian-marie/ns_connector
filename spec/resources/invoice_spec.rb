require 'spec_helper'

include NSConnector
describe Invoice do
	it 'should not explode on creation' do
		Invoice.new
	end
	
	it 'should have a to_pdf method' do
		Restlet.should_receive(:execute!).and_return(
			[Base64::encode64('yay')]
		)
		expect{Invoice.new.to_pdf}.to raise_error(
			::ArgumentError,
			/could not find id/i
		)
		expect(Invoice.new(:id => 1).to_pdf).to eql('yay')
	end
end

