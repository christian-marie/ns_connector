require 'ns_connector/restlet'
require 'ns_connector/errors'
require 'ns_connector/chunked_searching'
require 'ns_connector/field_store'
require 'ns_connector/hash'
require 'ns_connector/sublist'
require 'ns_connector/sublist_item'
require 'ns_connector/attaching'

# This is a 'meta' class that all our useful NetSuite classes inherit from,
# overriding what they may need to. For example:
# 	class Contact < Resource
# 	        # The NetSuite internal id for the object. 
#         	@type_id = 'contact'
# 	end
class NSConnector::Resource
	include NSConnector::FieldStore
	extend NSConnector::ChunkedSearching
	extend NSConnector::Attaching

	attr_accessor :store

	def initialize upstream_store=nil, in_netsuite=false
		upstream_store.stringify_keys! if upstream_store

		@store = (upstream_store || {})
		@sublist_store = {}

		# This is set so that we can tell wether we need to create an
		# entirely new netstuite object, or we are modifying an
		# existing one.
		@in_netsuite = in_netsuite

		check_id10t_errors!
		create_store_accessors!
		create_sublist_accessors!
	end

	# Just so I don't forget to define certain things.
	def check_id10t_errors!
		unless fields then
			raise ::ArgumentError,
				"Inherited class #{self.class} needs to "\
				"define @fields class instance variable"
		end
		# Type doesn't matter
		unless fields.include? 'id' or fields.include? :id
			raise ::ArgumentError,
				"Inherited class #{self.class} must define "\
				"an 'id' field"
		end
		unless type_id then
			raise ::ArgumentError,
				"Inherited class #{self.class} needs to "\
				"define @type_id class instance variable"
		end
		unless sublists then
			raise ::ArgumentError,
				"Inherited class #{self.class} needs to "\
				"define @sublists class instance variable"
		end
	end

	# Retrieve class's internal id, e.g. 'contact' for a Contact Resource
	def type_id
		self.class.type_id
	end

	# List of all fields for class
	def fields
		self.class.fields
	end

	# List of all sublists for class
	def sublists
		self.class.sublists
	end

	# Attach ids on target klass to this record
	# Arguments::
	#   klass:: Target class to attach to, e.g. Contact
	#   ids:: Array of ids to attach
	#   attributes:: Optional attributes for attach, e.g. {:role => -5}
	# Example::
	# 	contact.attach!(Customer, [1198], {:role => 1})
	def attach!(klass, ids, attributes=nil)
		raise ::ArgumentError, 'Need an id to attach!' unless id
		self.class.attach!(klass, id, ids, attributes)
	end

	# Detach ids on target klass to this record
	# Arguments::
	#   klass:: Target class to detach from, i.e. Contact
	#   ids:: Array of ids to detach
	def detach!(klass, ids)
		raise ::ArgumentError, 'Need an id to detach!' unless id
		self.class.detach!(klass, id, ids)
	end

	# Format an object like: '#<NSConnector::PseudoResource:1>'
	def inspect
		"#<NSConnector::#{self.class}:#{id.inspect}>"
	end

	# Is this resource already in NetSuite?
	# Returns:: 
	#   true:: if this resource has been retrieved from netsuite,
	#   false:: if it is a new resource being created for the first time.
	def in_netsuite?
		@in_netsuite
	end

	# Save ourself to NetSuite.
	#
	# Raises:: NSConnector::Errors various errors if something explodes
	# Returns:: true
	def save!
		# Convert all of our sublist objects to hashes
		sublists = Hash[@sublist_store.map {|sublist_id, objects|
			[sublist_id, objects.map {|object|
				object.to_hash
			}]
		}]

		@store = NSConnector::Restlet.execute!(
			:action => in_netsuite? ? 'update' : 'create',
			:type_id => type_id,
			:fields => fields,
			:data => @store,
			:sublists => sublists,
		)
		# If we got this far, we're probably in NetSuite
		@in_netsuite = true

		return true
	end

	# Delete ourself from NetSuite
	#
	# Returns::
	#   true:: If object deleted
	#   false:: If object was not deleted as it never existed
	def delete!
		return false unless in_netsuite? 
		fail 'Sanity check: resource should have an ID' unless id
		self.class.delete!(id)

		# We set our :id to nil as we don't have one anymore and it
		# allows us to call save on our newly deleted record, in case
		# we wanted to undelete or something crazy like that.
		@store[:id] = nil
		@in_netsuite = false

		return true
	end

	class << self
		# Provides accessibility to class instance variables
		attr_reader :type_id
		attr_reader :fields
		attr_reader :sublists

		# Delete a single ID from NetSuite
		#
		# Returns:: Nothing useful
		# Raises:: Relevant exceptions on failure
		def delete! id
			NSConnector::Restlet.execute!(
				:action => 'delete',
				:type_id => type_id,
				:data => {'id' => Integer(id)}
			)
		end

		# Retrieve a single resource from NetSuite with +id+
		def find id
			self.new(
				NSConnector::Restlet.execute!(
					:action => 'retrieve',
					:type_id => type_id,
					:fields => fields,
					:data => {'id' => Integer(id)}
				),
				true
			)
		end

		# Retrieve all records, will most likely become a chunked
		# search due to size
		def all
			advanced_search([])
		end

		# Perform a search by field, with value matching exactly
		def search_by field, value
			advanced_search([[field, nil, 'is', value]])
		end

		# Perform a flexible search. It is assumed you kind of know
		# what you're doing here and create a filter (a SuiteScript
		# nlobjSearchFilter)
		# Example::
		# 	Resource.advanced_search([
		# 		['type_id', nil, 'greaterthan', 1000],
		# 		['email', nil, 'contains', '@'],
		# 		[...]
		#	])
		# Arguments::
		#   +filters+:: An array of netsuite 'filters' see: +Filters+
		#
		# Filters::
		#   A filter is simply an array that is sent as arguments to
		#   the netsuite function +nlobjSearchFilter+
		#
		#   It often takes the form of:
		#   	[field, join record type or nil, operator, value]
		#
		#   i.e:
		#   	['internalid', nil, 'is', customer_id]
		#
		# Returns::
		#   An array of +Resources+
		def advanced_search filters
			unless filters.is_a? Array
				raise ::ArgumentError,
					'Expected an Array of filters'
			end

			return NSConnector::Restlet.execute!(
					:action => 'search',
					:type_id => type_id,
					:fields => fields,
					:data => {:filters => filters}
			).map do |upstream_store|
				self.new(upstream_store, true)
			end
		rescue NSConnector::Errors::BeginChunking
			# Result set is too large, we have to ask for
			# it in offsets. Note that if the result set
			# changes between requests say, at the
			# beginning, we are going to get odd behaviour.
			# Better than nothing, though.
			#
			# For this function, see:
			# ns_connector/chunked_searching.rb
			return search_by_chunks(filters)
		end

		# Quicker and more flexible than a normal search as it doesn't
		# return whole objects, just the search columns specified as an
		# array of arrays.
		#
		# Arguments::
		# columns:: Array of requested colums, e.g.:
		# 	[['role'], ['entityId', 'customer']] 
		# filters:: Array of filters, same as #advanced_search, e.g.:
		# 	[['entityId', 'customer', 'is', '296']]
		# Returns:: Array of result columns, in an array. So an array
		#   of arrays.
		def raw_search columns, filters
			return NSConnector::Restlet.execute!(
					:action => 'raw_search',
					:type_id => type_id,
					:fields => fields,
					:data => {
						:columns => columns,
						:filters => filters
					}
			)
		end
	end

	private
	# Given a sublist of {:addressbook => ['fields']} we want a method
	# addressbook that looks up the sublist if we have an ID, otherwise
	# returns an empty array.
	def create_sublist_accessors!
		sublists.each do |sublist_name, fields|
			self.class.class_eval do
				define_method sublist_name do
					# We are an object in netsuite,
					# we might just have sublist
					# items already. So we check.
					@sublist_store[sublist_name] ||= \
						NSConnector::SubList.fetch(
							self,
							sublist_name,
							fields
						) if in_netsuite?

					@sublist_store[sublist_name] ||= []
				end

				define_method(
					"new_#{sublist_name}_item"
				) do |upstream_store = nil|
					NSConnector::SubListItem.new(
						sublist_name,
						fields,
						self,
						upstream_store
					)
				end
			end
		end
	end
end
