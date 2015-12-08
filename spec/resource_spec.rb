require 'spec_helper'
include NSConnector

class PseudoResource < Resource
	# The NetSuite internal id for the object. For a Contact, it would be
	# 'contact'
	@type_id = 'pseudoresource'
	@fields = ['id', 'firstname', 'lastname']
	@sublists = {:notes => [:line]}
end

# We create another resource here to ensure no clashes in anything shared.
class OtherResource < Resource
	@type_id = 'otherresource'
	@fields = ['id', 'fax']
	@sublists = {}
end


describe PseudoResource do
	before :each do
		@p = PseudoResource.new
	end

	context '#new' do
		it 'has things we expect' do
			PseudoResource.type_id.should eql('pseudoresource')
			PseudoResource.fields.should eql(
				['id', 'firstname', 'lastname']
			)
			PseudoResource.sublists.should eql({:notes => [:line]})
		end

		it 'automatically loads field ids just once on #new' do
			PseudoResource.new
			expect(@p.fields).
				to eql(['id', 'firstname', 'lastname'])

			OtherResource.new
			o = OtherResource.new
			expect(o.fields).to eql(['id', 'fax'])
		end

		it 'allows us to pass stuff to new' do
			new_resource = PseudoResource.new(:firstname => 'first')
			expect(new_resource.firstname).to eql('first')
			expect(new_resource.lastname).to be_nil
			expect(new_resource).to_not be_in_netsuite

			in_ns_resource = PseudoResource.new(
				{:lastname => 'last'}, true
			)
			expect(in_ns_resource.lastname).to eql('last')
			expect(in_ns_resource.firstname).to be_nil
			expect(in_ns_resource).to be_in_netsuite
		end

		it 'allows fields to be read and set' do
			expect(@p.id).to be_nil
			expect(@p.firstname).to be_nil
			expect(@p.lastname).to be_nil

			@p.firstname = 'first'
			expect(@p.firstname).to eql('first')
			expect(@p.store).to eql({'firstname' => 'first'})

			# Ensure there is no odd behaviour here
			p2 = PseudoResource.new
			p2.firstname = 'second'

			expect(@p.firstname).to eql('first')
			expect(p2.firstname).to eql('second')
		end

		it 'does not exist in netsuite as it is new' do
			expect(PseudoResource.new).to_not be_in_netsuite
		end

		it 'saves as a new object when #save! is called' do
			ns_reply = {
				'firstname' => 'Name',
				'lastname' => 'nothing',
				'id' => '42'
			}

			@p.firstname = 'name'

			note_item1 = @p.new_notes_item(:line => 'line 1')
			note_item2 = @p.new_notes_item(:line => 'line 2')

			@p.notes << note_item1
			@p.notes << note_item2

			Restlet.should_receive(:execute!).
				with({
					:action => 'create',
					:type_id => 'pseudoresource',
					:fields => ['id', 'firstname', 'lastname'],
					:data => {'firstname' => 'name'},
					:sublists => { 
						:notes => [
							{'line' => 'line 1'},
							{'line' => 'line 2'}
						]
					},
				}).
				once.
				and_return(ns_reply)

			# Replace them, backways to test.
			SubList.should_receive(:save!).
				with([note_item1, note_item2], @p, :notes, [:line]).
				and_return([note_item2, note_item1])

			expect(@p.save!).to eql(true)

			expect(@p.firstname).to eql('Name')
			expect(@p.lastname).to eql('nothing')
			expect(@p.id).to eql('42')

			# Backwards now
			expect(@p.notes.first.line).to eql('line 2')
		end

		it 'has a pretty inspect' do
			expect(@p.inspect).to eql(
				'#<NSConnector::PseudoResource:nil>'
			)

			@p.instance_variable_set('@store', {'id' => 1})
			expect(@p.inspect).to eql(
				'#<NSConnector::PseudoResource:1>'
			)
		end
	end

	context 'reading' do
		it 'retrieves one resource with #find' do
			Restlet.should_receive(:execute!).
				with({
					:action => 'retrieve',
					:type_id => 'pseudoresource',
					:fields => [
						'id',
						'firstname',
						'lastname'
					],
					:data => {'id' => 42}
				}).and_return({'firstname' => 'dude man'})

			result = PseudoResource.find(42)
			expect(result).to be_a(PseudoResource)
			expect(result.firstname).to eql('dude man')
			expect(result).to be_in_netsuite
		end

		it 'retrieves multiple resources with #advanced_search' do
			expected_filters = [
				['entityId', nil, 'is', '42'],
				['email', nil, 'isempty']
			]

			Restlet.should_receive(:execute!).
				with({
					:action => 'search',
					:type_id => 'pseudoresource',
					:fields => [
						'id',
						'firstname',
						'lastname'
					],
					:data => {:filters => expected_filters}
				}).and_return([
					{'id' => 1, 'firstname' => 'unique'},
					{'id' => 2, 'firstname' => 'two'}
				])

			result = PseudoResource.advanced_search([
				['entityId', nil, 'is', '42'],
				['email', nil, 'isempty']
			])
			expect(result).to be_a(Array)
			expect(result.size).to eq(2)

			expect(result.first).to be_a(PseudoResource)
			expect(result.first.firstname).to eql('unique')
			expect(result.first.id).to eql(1)
			expect(result.first).to be_in_netsuite

			expect(result.last.firstname).to eql('two')
		end

		it 'has convenience method #search_by' do
			PseudoResource.
				should_receive(:advanced_search).
				with([['a', nil, 'is', 'b']]).
				and_return('nothing')
			expect(PseudoResource.search_by('a', 'b')).
				to eql('nothing')
		end

		it 'has convenience method #all' do
			PseudoResource.
				should_receive(:advanced_search).
				with([]).
				and_return('nothing')
			expect(PseudoResource.all).to eql('nothing')
		end

		it 'tries to chunk given BeginChunking' do
			Restlet.should_receive(:execute!).
				and_raise(Errors::BeginChunking, double)
			PseudoResource.should_receive(:search_by_chunks).
				and_return('hai')
			expect(PseudoResource.all).to eql('hai')
		end
	end

	shared_context 'found_resource' do
		before :each do
			Restlet.should_receive(:execute!).
				with({
					:action => 'retrieve',
					:type_id => 'pseudoresource',
					:fields => [
						'id',
						'firstname',
						'lastname'
					],
					:data => {'id' => 42}
				}).and_return(
					{
						'id' => '1',
						'firstname' => 'orig',
						'lastname' => 'orig'
					}
				)
			@found_resource = PseudoResource.find(42)
			expect(@found_resource.firstname).to eql('orig')
			expect(@found_resource).to be_in_netsuite
		end
	end

	context 'updating' do
		include_context 'found_resource'

		it 'updates existing record in NetSuite' do
			@found_resource.firstname = 'new'
			expect(@found_resource.firstname).to eql('new')

			Restlet.should_receive(:execute!).
				with({
					:action => 'update',
					:type_id => 'pseudoresource',
					:fields => [
						'id',
						'firstname',
						'lastname'
					],
					:data => {
						'firstname' => 'new',
						'lastname' => 'orig',
						'id' => '1'
					},
					:sublists => {}
				}).
				once.
				and_return({'firstname' => 'New'})

			@found_resource.save!

			expect(@found_resource.lastname).to be_nil
			expect(@found_resource.firstname).to eql('New')
		end
	end

	context 'deleting' do
		include_context 'found_resource'

		it 'tries to delete ID via class method' do
			Restlet.should_receive(:execute!).
				with({
					:action => 'delete',
					:type_id => 'pseudoresource',
					:data => {
						'id' => 42
					}
				}).
				once.and_return([])
			PseudoResource.delete!(42)
		end

		it 'tries to delete ID via instance method' do
			Restlet.should_receive(:execute!).
				with({
					:action => 'delete',
					:type_id => 'pseudoresource',
					:data => {
						'id' => 1
					}
				}).
				once.and_return([])
			@found_resource.delete!
		end

		it 'returns false trying to delete an object not in NS' do
			expect(@p.delete!).to be false
		end
	end

	context 'sublists on new object' do
		it 'is empty' do
			p = PseudoResource.new
			expect(p.notes).to be_empty
		end

		it 'can append a new list to blank object' do
			p = PseudoResource.new
			expect(p.new_notes_item).to be_a(NSConnector::SubListItem)
			p.notes << p.new_notes_item(:line => 'line 1')
			p.notes << p.new_notes_item(:line => 'line 2')

			expect(p.notes.pop.line).to eql('line 2')
			expect(p.notes.pop.line).to eql('line 1')
		end
	end

	context 'raw search' do
		it 'has #raw_search' do
			Restlet.should_receive(:execute!).
				with({
					:action => 'raw_search',
					:type_id => 'pseudoresource',
					:fields => [
						'id', 'firstname', 'lastname'
					],
					:data => {
						:columns => [['a']],
						:filters => [['b']]
					}
				}).
				once.and_return(['hai'])
			expect(PseudoResource.raw_search([['a']], [['b']])).
			       to eql(['hai'])
		end
	end

	context 'transform' do
		include_context 'found_resource'
		it 'transform! s' do
			Restlet.should_receive(:execute!).
				with({
					:action=>"transform",
					:source_type_id=>"pseudoresource",
					:target_type_id=>"otherresource",
					:source_id=>"1", 
					:fields=>["id", "fax"],
					:data=>{"fax"=>"123"}
				})

			@found_resource.transform!(OtherResource) do |o|
				expect(o).to be_a(OtherResource)
				o.fax = '123'
			end
		end
	end

	context 'link aliases' do
		include_context 'found_resource'

		it 'has #link' do
			PseudoResource.should_receive(:attach!).
				with(OtherResource, '1', [1,2], nil)
			@found_resource.attach!(OtherResource, [1,2])

			expect{@p.attach!(OtherResource, [1,2])}.to raise_error(
				::ArgumentError, /need an id/i
			)
		end

		it 'has #unlink' do
			PseudoResource.should_receive(:detach!).
				with(OtherResource, '1', [1,2])
			@found_resource.detach!(OtherResource, [1,2])

			expect{@p.detach!(OtherResource, [1,2])}.to raise_error(
				::ArgumentError, /need an id/i
			)
		end
	end
end
