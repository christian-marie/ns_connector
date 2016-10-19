require 'spec_helper'
include NSConnector

describe Restlet do
  context 'given a valid config' do
    before(:each) do
      NSConnector::Config.set_config! valid_config
    end

    it 'executes a restlet, passing the options' do
      options = {:opt1 => 'value1', :opt2 => 'value2'}
      expected_body = options.merge(
        :code => Restlet.restlet_code
      ).to_json

      # We already test the auth header below. We simply test
      # its existance here.
      expected_request = {
        :body => expected_body,
        :headers => {
          'Authorization' => /^NLAuth/,
          'Content-Type'=>'application/json',
          'User-Agent' => 'Restlet Test UA'
        }
      }

      stub_request(:post, "https://netsuite:1234/restlet?").
        with(expected_request).
        to_return(
          :status => 200,
          :body => '["json"]',
      )
      expect(Restlet.execute!(options)).to eql(['json'])
    end

    it 'fails gracefully with 500' do
      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 500, :body => 'message')
      expect{Restlet.execute!({})}.to raise_error(
        Restlet::RuntimeError,
        /500: message/
      )
    end

    it 'tries to create a nice error from a 400' do
      # Acutal netsuite responses as of 7 Jun 13
      #
      # RCRD_DSNT_EXIST -> NotFound
      error = '{"error" : {"code" : "RCRD_DSNT_EXIST", '\
        '"message" : "That record does not exist."}}'

      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 400, :body => error)
      expect{Restlet.execute!({})}.to raise_error(
        Errors::NotFound, /does not exist/
      )

      # ANYTHING represents 'CONTACT' or 'CUSTOMER', or
      # Whatever
      #
      # ANYTHING_ALREADY_EXISTS -> Conflict
      error = '{"error" : {"code" : '\
      '"ANYTHING_ALREADY_EXISTS", '\
      '"message" : "A contact record with this name '\
      'already exists. Every contact record must have '\
      'a unique name."}}'

      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 400, :body => error)
      expect{Restlet.execute!({})}.to raise_error(
        Errors::Conflict, /A contact record/
      )
    end

    it 'creates a Unknown error from parseable but unknown JSON' do
      error = '{"error" : {"code" : "GREEN_ROOM", '\
        '"message" : "This room is... Green."}}'

      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 400, :body => error)
      expect{Restlet.execute!({})}.to raise_error(
        Errors::Unknown, /room is/
      )
    end

    it 'creates a WTF error from unparseable JSON' do
      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 400, :body => 'omgwtf')
      expect{Restlet.execute!({})}.to raise_error(
        Errors::WTF, /omgwtf/
      )
    end

    it 'fails gracefully with bad JSON' do
      stub_request(:post, "https://netsuite:1234/restlet?").
        to_return(:status => 200, :body => 'omgwtf')
      expect{Restlet.execute!({})}.to raise_error(
        Restlet::RuntimeError,
        /omgwtf.*unexpected token/
      )
    end


    it 'generates a valid auth header' do
      expect(Restlet.auth_header(nil)).to eql(
        'NLAuth nlauth_account=account_id,' \
        'nlauth_email=email@site,'          \
        'nlauth_role=123,'                  \
        'nlauth_signature=pass%00word'
      )
    end

    it 'retrieves code' do
      expect(Restlet.restlet_code).to be_a(String)
      expect(Restlet.restlet_code).to_not be_empty
    end
  end

  context 'given an invalid config' do
    before(:each) do
      NSConnector::Config.set_config!(:invalid => true)
    end

    it 'everything raises ArgumentError' do
      expect{Restlet.execute!({})}.
        to raise_error(
          NSConnector::Config::ArgumentError
        )

      expect { Restlet.auth_header(nil) }.
        to raise_error(
          NSConnector::Config::ArgumentError
        )
    end
  end

  context 'given oauth config' do
    before :each do
      NSConnector::Config.set_config! valid_oauth_config
    end

    it "generates an oauth header" do
      oauth = double(:oauth, header: :some_header)
      expect(NSConnector::OAuth).to receive(:new).with(NSConnector::Config, :request) { oauth }
      expect(Restlet.auth_header(:request)).to eq(:some_header)
    end
  end
end
