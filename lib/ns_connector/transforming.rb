# Provide a transform! method
module NSConnector::Transforming
	# Transform record to target class, given id.
	# Optionally set fields on the target record before saving if passed
	# block.
	# Arguments:: 
	#   klass:: target class to transform into, e.g. CustomerPayment
	#   id:: internal id of source record to transform
	#   &block:: optional block, passed a newly created object of target
	#   	klass, anything you set on this class will be set in netsuite
	#   	before saving the newly created object.
	# Example::
	# 	Invoice.transform!(CustomerPayment, 500) do |payment|
	# 		payment.ccnumber = '422222222'
	# 		payment.ccexpiry = 'invalid'
	# 	end
	# 	=> #<NSConnector::NSConnector::CustomerPayment:"123">
	def transform!(klass, id, &block)
		target = klass.new
		if block_given? then
			# User sets what they want on the target
			yield target
		end

		NSConnector::Restlet.execute!(
			:action => 'transform',
			:source_type_id => type_id,
			:target_type_id => klass.type_id,
			:source_id => id,
			:fields => klass.fields,
			:data => target.store
		)
	end
end
