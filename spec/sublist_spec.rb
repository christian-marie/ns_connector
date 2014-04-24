require 'spec_helper'
include NSConnector

describe SubList do
	before :each do
		@parent = double(
			'contact', :type_id => 'contact', :id => '42'
		)
		@item1 = SubListItem.new(
			'sublist', ['field1', 'field2'], @parent, 
			:field1 => 'data'
		)
		@item2 = SubListItem.new(
			'sublist', ['field1', 'field2'], @parent,
			:field2 => 'otherdata'
		)
	end

	it 'fetches' do
		Restlet.should_receive(:execute!).
			with({
				:action => 'fetch_sublist',
				:type_id => 'contact',
				:parent_id => '42',
				:sublist_id => 'sublist',
				:fields => ['field1', 'field2'],
			}).and_return(
				[
					{'field1' => 'new'},
					{'field2' => 'new2'},
				]
			)
		sublist = SubList.fetch(
			@parent, 'sublist', ['field1', 'field2']
		)

		expect(sublist).to be_a(Array)
		expect(sublist).to have(2).things
		sublist.each do |item|
			expect(item).to be_a(SubListItem)
		end
		expect(sublist.first.field1).to eql('new')
		expect(sublist.last.field2).to eql('new2')
	end

	it 'saves' do
		Restlet.should_receive(:execute!).
			with({
				:action => 'update_sublist',
				:type_id => 'contact',
				:parent_id => '42',
				:sublist_id => 'sublist',
				:fields => ['field1', 'field2'],
				:data => [
					{'field1' => 'data'},
					{'field2' => 'otherdata'}
				]
			}).and_return(
				'true'
			)

		SubList.should_receive(:fetch).and_return('hai')
		# Duplicates should be ignored, I figure? I'll be a little
		# confused if duplicates ever appear in NetSuite
		saved = SubList.save!(
			[@item1, @item1, @item2],
			@parent, 
			'sublist',
			['field1', 'field2']
		)

		expect(saved).to eql('hai')
	end
end
