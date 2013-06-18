require 'spec_helper'

class MagicResource 
	extend NSConnector::Transforming 
	def initialize 
	end
	def self.type_id
		'magic'
	end
end

class MagicTarget 
	attr_reader :store
	extend NSConnector::Transforming
	def initialize 
		@store = {}
	end
	def field1=(v)
		@store[:field1] = v
	end
	class << self
		def type_id
			'target'
		end
		def fields
			[:field1]
		end
	end
end

describe NSConnector::Transforming do
	it 'transform! with no block works' do
		NSConnector::Restlet.should_receive(:execute!).with({
			:action => 'transform',
			:source_type_id => 'magic',
			:target_type_id => 'target',
			:source_id => 42,
			:data => {},
			:fields => [:field1]
		})

		MagicResource.transform!(MagicTarget, 42)
	end
	it 'transform! with no block works' do
		NSConnector::Restlet.should_receive(:execute!).with({
			:action => 'transform',
			:source_type_id => 'magic',
			:target_type_id => 'target',
			:source_id => 42,
			:data => {:field1 => 'value'},
			:fields => [:field1]
		})

		MagicResource.transform!(MagicTarget, 42) do |magic_target|
			magic_target.field1 = 'value'
		end
	end
end
