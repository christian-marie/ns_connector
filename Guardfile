guard :rspec do
	watch(%r{^spec/.+_spec\.rb$})
	watch(%r{^lib/ns_connector/(.+)\.rb$}){ |m| 
		puts "#{m[1]}"
		"spec/#{m[1]}_spec.rb" 
	}
	watch('spec/spec_helper.rb'){ "spec" }
end

