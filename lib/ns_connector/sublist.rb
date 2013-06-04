# Provides a method for grabbing sublists
module NSConnector::SubList
	# Grab sublist_id from NetSuite
	# Returns:: An array of SubListItems
	def self.fetch parent, sublist_id, fields
		NSConnector::Restlet.execute!(
			:action => 'fetch_sublist',
			:type_id => parent.type_id,
			:parent_id => parent.id,
			:fields => fields,
			:sublist_id => sublist_id
		).map do |upstream_store|
			NSConnector::SubListItem.new(
				sublist_id,
				fields,
				parent,
				upstream_store
			)
		end
	end
end
