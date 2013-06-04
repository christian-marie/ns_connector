require 'spec_helper'

class MagicResource 
	extend NSConnector::Attaching 
	def initialize upstream_store
	end
	def self.type_id
		'magic'
	end
end

class MagicTarget 
	extend NSConnector::Attaching
	def initialize upstream_store
	end
	def self.type_id
		'target'
	end
end

describe NSConnector::Attaching do
	it 'attach! works' do
		NSConnector::Restlet.should_receive(:execute!).with({
			:action => 'attach',
			:type_id => 'magic',
			:target_type_id => 'target',
			:attachee_id => 42,
			:data => [1,2,3],
			:attributes => nil,
		})

		MagicResource.attach!(MagicTarget, 42, [1,2,3])
	end


	it 'detach! works' do
		NSConnector::Restlet.should_receive(:execute!).with({
			:action => 'detach',
			:type_id => 'magic',
			:target_type_id => 'target',
			:attachee_id => 42,
			:data => [1,2,3]
		})

		MagicResource.detach!(MagicTarget, 42, [1,2,3])
	end
end

