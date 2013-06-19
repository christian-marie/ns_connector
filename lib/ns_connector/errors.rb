# A collection of useful, catchable, and usually netsuite related errors.
#
# For a list of errors that can be returned and conditions for returning said
# errors, see #try_handle_response!
module NSConnector::Errors
	# Parent class to encapsulate all successfully parsed JSON netsuite
	# error responses. 
	class NSError < Exception
		def initialize netsuite_error
			@netsuite_error = netsuite_error
		end

		# Returns the error code from the JSON returned by netsuite.
		# Something like: "RCRD_DSNT_EXIST"
		def code
			@netsuite_error['code']
		end

		# Takes the error message straight out of the netsuite
		# response. Usually makes some sense.
		def message
			@netsuite_error['message']
		end
	end

	# Not found
	NotFound = Class.new(NSError)
	# Some field has a unique constraint on it which has a duplicate
	Conflict = Class.new(NSError)
	# Usually a search run on an invalid field
	InvalidSearchFilter = Class.new(NSError)
	# Credit card processing problems
	CCProcessorError = Class.new(NSError)

	# Internal use 
	BeginChunking = Class.new(NSError)
	# Internal use 
	EndChunking   = Class.new(NSError)

	# Unknown errors should still have a #code and #message that is useful.
	# They are raised when we got a JSON error response from NetSuite that
	# we simply don't cater explicitly for.
	Unknown = Class.new(NSError)

	# Complete garbage received
	WTF = Class.new(RuntimeError)

	# Try and make a HTTP response from netsuite a nice error.
	# Arguments:: A Net::HTTP response, should be a 400
	# Raises::
	#   NSConnector::Errors::NotFound:: on a RCRD_DSNT_EXIST
	#   NSConnector::Errors::InvalidSearchFilter:: on a
	#   	SSS_INVALID_SRCH_FILTER
	#   NSConnector::Errors::Conflict:: on a *_ALREADY_EXISTS
	#   NSConnector::Errors::Unknown:: on any unhandled but parseable error
	#   NSConnector::Errors::WTF:: on complete garbage from netsuite 
	# 
	# Returns:: Shouldn't return
	def self.try_handle_response! response
		error = JSON.parse(response.body)['error']
		case error['code']
		when 'RCRD_DSNT_EXIST'
			raise NotFound, error
		when 'SSS_INVALID_SRCH_FILTER'
			raise InvalidSearchFilter, error
		when 'CC_PROCESSOR_ERROR'
			raise CCProcessorError
		when /_ALREADY_EXISTS$/
			raise Conflict, error
		else
			case error['message']
			when 'CHUNKY_MONKEY'
				raise BeginChunking, error
			when 'NO_MORE_CHUNKS'
				raise EndChunking, error
			end
			raise Unknown, error
		end
	rescue JSON::ParserError
		raise WTF, 'Unparseable response, expecting JSON. '\
			"HTTP #{response.code}: \n#{response.body}"
	end
end
