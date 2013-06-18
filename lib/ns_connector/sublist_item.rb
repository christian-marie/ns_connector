require 'ns_connector/field_store'
require 'ns_connector/hash'

# Represents one SubListItem under a Resource
class NSConnector::SubListItem
	include NSConnector::FieldStore
	attr_accessor :store
	attr_accessor :parent
	attr_accessor :name
	attr_accessor :fields

	def initialize name, fields, parent, upstream_store = nil
		upstream_store.stringify_keys! if upstream_store
		@store = (upstream_store || {})
		@parent = parent
		@fields = fields
		@name = name

		create_store_accessors!
	end

	def inspect
		"#<NSConnector::#{self.class}:#{name}>"
	end

	def to_hash
		@store
	end
end
