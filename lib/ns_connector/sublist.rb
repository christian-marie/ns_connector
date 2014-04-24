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

	# Save our array of SubListItems in the order in which they appear.
	# Arguments:: An array of SubListItem, the parent object and the fields
	# Returns:: An array of SubListItem that have been saved
	def self.save! sublist_items, parent, sublist_id, fields
		data = sublist_items.uniq.map do |item|
			item.store
		end

		NSConnector::Restlet.execute!(
			:action => 'commit_sublist_changes',
			:type_id => parent.type_id,
			:parent_id => parent.id,
			:fields => fields,
			:sublist_id => sublist_id,
			:data => data
		)

		# We have to do this in a second request as NetSuite needs a
		# short time to think about any added records.
		return NSConnector::SubList.fetch(parent, sublist_id, fields)
	end
end
