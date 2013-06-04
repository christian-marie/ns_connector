require 'spec_helper'
include NSConnector

describe SubListItem do
	context 'new' do
		before :each do
			parent = double(
				'contact', :type_id => 'contact', :id => '42'
			)
			@s = SubListItem.new('sublist', ['field1', 'field2'], parent)
		end

		it 'has things we expect' do
			expect(@s.field1).to eql(nil)
			@s.field1 = 'yay'
			expect(@s.field1).to eql('yay')
			expect(@s.field2).to eql(nil)
		end

		it 'has a .store' do
			@s.field1 = 'yay'
			expect(@s.store).to eql('field1' => 'yay')
		end
	end
end
