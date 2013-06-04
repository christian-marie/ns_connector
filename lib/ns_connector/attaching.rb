# Provide attach! and detach! methods
module NSConnector::Attaching
	# Attach any number of ids to klass
	# Arguments:: 
	#   klass:: target class to attach to, i.e. Contact
	#   attachee_id:: internal id of the record to make the attach(s) to
	#   ids:: array of target ids
	#   attributes:: optional attributes for the attach, i.e. {:role => -5}
	def attach!(klass, attachee_id, ids, attributes = nil)
		unless ids.kind_of?(Array) then
			raise ::ArgumentError, 
				'Expected ids to be an array'
		end
		NSConnector::Restlet.execute!(
			:action => 'attach',
			:type_id => type_id,
			:target_type_id => klass.type_id,
			:attachee_id => attachee_id,
			:attributes => attributes,
			:data => ids
		)
	end

	# Unattach any number of ids to klass
	# Arguments:: 
	#   klass:: target class to detach from, i.e. Contact
	#   attachee_id:: internal id of the record to make the detach(s) from
	#   ids:: array of target class ids 
	def detach!(klass, attachee_id, ids)
		unless ids.kind_of?(Array) then
			raise ::ArgumentError, 
				'Expected ids to be an array'
		end
		NSConnector::Restlet.execute!(
			:action => 'detach',
			:type_id => type_id,
			:target_type_id => klass.type_id,
			:attachee_id => attachee_id,
			:data => ids
		)
	end
end
