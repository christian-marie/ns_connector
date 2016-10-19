require 'spec_helper'
require 'oauth'

describe NSConnector::OAuth do
  describe '#header' do
    let(:config) { valid_oauth_config }
    let(:request) { Net::HTTP::Post.new(URI.parse('http://example.com/restlet')) }

    it "delegates to ::OAuth::Client::Helper" do
      expect_any_instance_of(::OAuth::Client::Helper).to receive(:header) { :auth_header }
      expect(NSConnector::OAuth.new(config, request).header).to eq(:auth_header)
    end
  end
end
