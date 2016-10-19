require 'securerandom'
require 'openssl'
require 'cgi'

module NSConnector
  class OAuth
    def initialize(config, request)
      @creds = config[:oauth]
      @realm = config[:account_id]
      @request = request
    end

    def header
      require 'oauth'
      helper.header
    end

    private

    def helper
      ::OAuth::Client::Helper.new(
        @request,
        consumer: consumer,
        token: token,
        request_uri: @request.uri,
        realm: @realm,
      )
    end

    def consumer
      ::OAuth::Consumer.new(@creds[:client_id], @creds[:client_secret])
    end

    def token
      ::OAuth::RequestToken.from_hash(
        consumer,
        oauth_token: @creds[:token_id],
        oauth_token_secret: @creds[:token_secret],
      )
    end
  end
end
