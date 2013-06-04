# Provides a method create_store_store_accessors! to make keys fields
# accessible in @store
module NSConnector::FieldStore
	# Given fields of ['name'], we want to define a name= and a name
	# method to retrieve and set the key 'name' in our @store
	def create_store_accessors!
		fields.each do |field|
			self.class.class_eval do 
				define_method field do
					@store[field.to_s]
				end

				define_method "#{field}=" do |value|
					@store[field.to_s] = value
				end
			end
		end
	end
end
