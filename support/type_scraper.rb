#!/usr/bin/env ruby

require "nokogiri"
require "uri"
require "erb"
require "ostruct"
require "open-uri"

if ARGV.length < 2
	puts "NetSuite type scraper"
	puts "Turns NetSuite record documentation into ns_connector classes"
	puts "Usage: type-scraper.rb (internal id) (final class name) > lib/ns_connector/resources/(ruby file name).rb"
	exit 1
end

page = ARGV[0]
class_name = ARGV[1]

# NB: Index of types is at
# https://system.netsuite.com/help/helpcenter/en_US/RecordsBrowser/2012_2/index.html

url = "https://system.netsuite.com/help/helpcenter/en_US/RecordsBrowser/2012_2/Records/#{page}.html"
bogus_ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.73.11 (KHTML, like Gecko) Version/6.1.1 Safari/537.73.11"

raw = []

open(url, "User-Agent" => bogus_ua) {|f|
	f.each_line {|line|
		raw << line
	}
}

html_doc = Nokogiri::HTML(raw.join("\n"))

record_id = nil
fields = [:id]
sublists = {}

record_ident = html_doc.css('.record_id').first.content.gsub('Internal ID: ', '')

# Fields

fields_table = html_doc.css('table.record_table').first

fields_table.css('tr').each_with_index do |row, i|
	next if i == 0

	record_cell = row.css('td').first
	fields << record_cell.content.gsub(/^\s+/, '').gsub(/\s+$/, '').to_sym
end

# Record shit

html_doc.css('.record_item').each do |r|
	if r.content.downcase == "sublists"
		row_table = r.parent.parent.parent
		row_table.next_element.css('tr').each_with_index do |row, i|
			next if i == 0

			record_cell = row.css('td').first.css('a').first
			sublist_name = record_cell.content.downcase.to_sym
			sublists[sublist_name] = []
		end
	end
end

html_doc.css('body > div.sublist').each do |r|
	if r.content.downcase =~ / sublist fields$/
		sublist_name = nil

		r.next_element.css('tr').each_with_index do |row, i|
			next if i == 0

			record_cell = row.css('td').first

			if i == 1
				sublist_name = row.css('td').first.content.downcase.to_sym
				record_cell = row.css('td')[1]
			end

			sublist_value = record_cell.content.downcase.to_sym
			sublists[sublist_name] << sublist_value
		end
	end

	
end

ns = OpenStruct.new({
	resource_type: class_name,
	resource_type_ident: record_ident,
	fields: fields,
	sublists: sublists
})

class_content = ERB.new(
	File.read(File.join(
		File.dirname(__FILE__), "type_scraper.tpl.erb"
	)),
	nil,
	'-'
).result(
	ns.instance_eval { binding }
)

puts class_content
