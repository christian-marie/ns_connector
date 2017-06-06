require 'net/https'
require 'uri'
require 'json'
require 'ns_connector/config'
require 'ns_connector/errors'
require 'ns_connector/oauth'

# Connects to the RESTlet configured in NetSuite to make generic requests.
# Example usage:
#  NSConnector::Restlet.execute!(
#    :action => 'retrieve',
#    :type_id => type_id,
#    :data => {'_id' => Integer(id)}
#  )
#  => parsed json results
module NSConnector::Restlet
  RuntimeError = Class.new(Exception)
  ArgumentError = Class.new(Exception)

  # Build a HTTP request to connect to NetSuite RESTlets, then request
  # our magic restlet that can do everything useful.
  #
  # Returns:: The parsed JSON response, i.e. JSON.parse(response.body)
  def self.execute!(options)
    NSConnector::Config.check_valid!

    # turn on netsuite-level debug from application
    options[:restlet_debug] = NSConnector::Config[:restlet_debug]

    # Build our request up, a bit ugly
    uri = URI(NSConnector::Config[:restlet_url])

    unless uri.scheme
      raise NSConnector::Restlet::ArgumentError,
        'Configuration value restlet_url must at '\
        'least contain a scheme (i.e. http://)'
    end

    http = Net::HTTP.new(uri.host, uri.port)

    if NSConnector::Config[:debug] then
      http.set_debug_output $stderr
    end

    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Post.new(uri)

    request['Content-Type'] = 'application/json'
    request['User-Agent'] = NSConnector::Config[:user_agent] if NSConnector::Config[:user_agent]

    begin
      options[:code] = restlet_code
      request.body = JSON.dump(options)
    rescue JSON::GeneratorError => current
      exception = NSConnector::Restlet::ArgumentError.new(
        "Failed to convert options (#{options}) " \
        "into JSON: #{current.message}"
      )

      exception.set_backtrace(current.backtrace)
      raise exception
    end

    request['Authorization'] = NSConnector::Restlet.auth_header(request)

    response = http.request(request)

    # Netsuite seems to use HTTP 400 (bad requests) for all runtime
    # errors.  Hah.
    if response.kind_of? Net::HTTPBadRequest then
      # So let's try and raise this exception as something
      # nicer.
      NSConnector::Errors.try_handle_response!(response)
    end

    unless response.kind_of? Net::HTTPSuccess then
      raise NSConnector::Restlet::RuntimeError.new(
        'Restlet execution failed, expected a '\
        'HTTP 2xx response, got a HTTP '\
        "#{response.code}: #{response.body}"
      )
    end

    if response.body.nil? then
      raise NSConnector::Restlet::RuntimeError.new(
        "Recieved a blank response from RESTlet"
      )
    end

    begin
      return JSON.parse(response.body)
    rescue JSON::ParserError => current
      exception = NSConnector::Restlet::RuntimeError.new(
        'Failed to parse response ' \
        'from Restlet as JSON '\
        "(#{response.body}): " \
        "#{current.message}"
      )
      exception.set_backtrace(current.backtrace)
      raise exception
    end
  end

  # Generate a NetSuite specific Authorization header.
  #
  # From the NetSuite documentation:
  #
  # NLAuth passes in the following login credentials:
  # +nlauth_account+::  NetSuite company ID (required)
  # +nlauth_email+::  NetSuite user name (required)
  # +nclauth_signature+::  NetSuite password (required)
  # +nlauth_role+::   internal ID of the role used to log in to
  #       NetSuite (optional)
  # The Authorization header should be formatted as:
  #   NLAuth<space><comma-separated parameters>
  #
  # For example:
  # Authorization: NLAuth nlauth_account=123456, \
  # nlauth_email=jsmith@ABC.com, nlauth_signature=xxxxxxxx, \
  # nlauth_role=41
  #
  # Returns:: String with the contents of the header
  def self.auth_header(request)
    c = NSConnector::Config
    c.check_valid!

    if c.key?(:oauth)
      NSConnector::OAuth.new(c, request).header
    else
      "NLAuth nlauth_account=#{c[:account_id]},"     \
      "nlauth_email=#{c[:email]},"                   \
      "nlauth_role=#{c[:role]},"                     \
      "nlauth_signature=#{URI.escape(c[:password])}"
    end
  end

  # Retrieve restlet code from support/restlet.js
  # Returns:: String
  def self.restlet_code
    restlet_location = File.join(
      File.dirname(__FILE__),
      '..', '..', 'support', 'restlet.js'
    )
    File.read(restlet_location)
  end
end
