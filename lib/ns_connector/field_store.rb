# Provides a method create_store_store_accessors! to make keys fields
# accessible in @store
module NSConnector::FieldStore
	# Given fields of ['name'], we want to define a name= and a name
	# method to retrieve and set the key 'name' in our @store
	def create_store_accessors!
		fields.each do |field|
			self.class.class_eval do
				# Let's determine the name of our helper method.
				# This makes sure we don't inadvertantly nuke a field that already exists,
				# such as "class".
				method_name = field.to_s
				while self.respond_to? method_name.to_sym
					method_name = "_" + method_name
				end
				method_name = method_name.to_sym

				define_method method_name do
					@store[field.to_s]
				end

				define_method "#{method_name}=" do |value|
					@store[field.to_s] = value
				end
			end
		end
	end
end
