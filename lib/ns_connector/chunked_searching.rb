# Provide threaded and non-threaded chunked searching
module NSConnector::ChunkedSearching
	# Retrieve a single chunk, this makes one HTTP connection
	# Raises:: NSConnector::Errors::EndChunking when there's no more chunks
	# Returns:: Resource objects
	def grab_chunk(filters, chunk)
		NSConnector::Restlet.execute!(
			:action => 'search',
			:type_id => type_id,
			:fields => fields,
			:data => {
				:filters => filters,
				:chunk => chunk,
			}
		).map do |upstream_store|
			self.new(upstream_store)
		end
	end

	# The basic logic here is, given four threads we have four workers,
	# those workers keep eating chunks of data specified by the master.
	# When a worker recieves a EndChunking error, it flags done as true and
	# everyone wraps up thier work. Pretty simple.
	def threaded_search_by_chunks(filters)
		require 'thread'
		threads = NSConnector::Config[:no_threads].to_i
		if threads < 1 then
			raise NSConnector::Config::ArgumentError, 
				"Need more than #{threads} threads"
		end

		# We bother pre-populating the queue here because locking is
		# super expensive, on my build of ruby at least.
		queue = Queue.new
		(threads - 1).times do |i|
			queue << i
		end

		mutex = Mutex.new

		workers = []
		results = []
		current_chunk = threads - 1
		done = false

		# Workers
		threads.times do
			workers << Thread.new do
				until done
					begin
						# Avoid a deadlock by popping
						# off -1 to exit
						chunk = queue.pop 
						break if chunk == -1

						result = grab_chunk(
							filters, chunk
						)
					rescue NSConnector::Errors::EndChunking
						done = true
						break
					rescue Timeout::Error
						retry
					end

					mutex.synchronize do
						results += result
					end
				end
			end
		end

		# Master
		until done
			if queue.empty? then
				queue << current_chunk
				current_chunk += 1
			end
		end

		threads.times do 
			queue << -1
		end

		workers.each do |worker|
			worker.join
		end

		return results
	end

	# Just keep grabbing incremental chunks till we're told to stop.
	def normal_search_by_chunks(filters)
		results = []
		chunk = 0
		while true
			begin
				results += grab_chunk(filters, chunk)
				chunk += 1
			end
		end
	rescue NSConnector::Errors::EndChunking
		return results
	end

	# Search by requesting chunks
	def search_by_chunks filters
		if NSConnector::Config[:use_threads] then
			return threaded_search_by_chunks(filters)
		else
			return normal_search_by_chunks(filters)
		end
	end
end
