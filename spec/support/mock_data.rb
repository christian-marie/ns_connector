# Valid configuration hash for NSConnector::Config
def valid_config
	{
		:account_id  => 'account_id',
		:email    => 'email@site',
		:password    => "pass\0word",
		:role        => '123',
		:restlet_url => 'https://netsuite:1234/restlet',
		:user_agent  => 'Restlet Test UA'
	}
end

def valid_oauth_config
  {
    account_id: '654321',
    role: '123',
    restlet_url: 'https://netsuite.example.com/restlet',
    oauth: {
      token_id: 'the_token_id',
      token_secret: 'the_token_secret',
      client_id: 'the_client_id',
      client_secret: 'the_client_secret',
    },
  }
end
