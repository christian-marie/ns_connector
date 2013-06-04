# A 'global' config.
#
# Being global, we are restricted to connecting to one NetSuite upstream URL
# per ruby process.
class NSConnector::Config
	@@options = {}
	ArgumentError = Class.new(Exception)
	DEFAULT = {
		:use_threads => true,
		:no_threads => 4
	}

	class << self
		# Read a key stored in @@options: Config[:key]
		def [](key)
			key = key.to_sym
			val = @@options[key]

			val.nil? ? DEFAULT[key] : val
		end

		# Write a key stored in @@options: Config[:key] = 1
		def []=(key, value)
			@@options[key.to_sym] = value
		end

		# Overwrite the current 'global' config with +options+
		def set_config! options
			@@options = {}
			options.each do |k,v|
				@@options[k.to_sym] = v
			end
		end

		# Check if the current config is valid.
		# Returns:
		# true:: if all required keys are supplied
		# Raises:
		# ArgumentError:: if any keys are missing
		def check_valid!
			unless @@options then
				raise NSConnector::Config::ArgumentError,
					'Need a configuration set. '\
					'See: NSConnector::Config.set_config!'
			end

			required = [
				:account_id, 
				:email,
				:password,
				:role,
				:restlet_url
			]

			missing_keys = (required - @@options.keys)
			unless missing_keys.empty?
				raise NSConnector::Config::ArgumentError, 
					'Missing configuration key(s): '\
					"#{missing_keys.join(', ')}"
			end

			# All good
			return true
		end
	end
end
