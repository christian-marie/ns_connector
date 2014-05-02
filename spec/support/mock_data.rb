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
