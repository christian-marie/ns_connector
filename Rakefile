require 'rubygems'
require 'bundler'
begin
	Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
	warn e.message
	warn "Run `bundle install` to install missing gems"
	exit e.status_code
end

require 'rdoc/task'
require 'jeweler'
require 'rspec/core/rake_task'

Jeweler::Tasks.new do |gem|
	gem.name = "ns_connector"
	gem.homepage = ""
	gem.summary = "An interface to NetSuite records via RESTlets."
	gem.description = "This library provides an interface to NetSuite via"\
		"‘RESTlets’. This appears to be a quicker and more reliable"\
		"way of interfacing with NetSuite records than the SOAP API."
	gem.authors = ["Christian Marie"]
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test
RSpec::Core::RakeTask.new :test 

task :deploy_to_hopper => [:build, :rdoc, :test] do
	`scp pkg/anchor_api-$(cat VERSION).gem packages@hopper.engineroom.anchor.net.au:public_html/gems/gems/`
	`scp -r html/* packages@hopper.engineroom.anchor.net.au:public_html/gems/docs/anchor_api/`
	`ssh packages@hopper.engineroom.anchor.net.au "cd /home/packages/public_html/gems && make"`
	if $?.to_i == 0 then
		 puts "Deploy to hopper successful"
	else
	       raise RuntimeError, "Deploy failed :("
	end
end

Rake::RDocTask.new do |rd|
	rd.main = "README.rdoc"
	rd.title = 'NSConnector documentation'
	rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end
