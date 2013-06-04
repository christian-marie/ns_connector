class Hash # :nodoc:
	# Turn all our keys into strings. Good for our @stores as they use
	# strings from keys seeing as anything coming from JSON has strings for
	# keys
	def stringify_keys!
		keys.each do |key|
			self[key.to_s] = delete(key)
		end
		self
	end
end
