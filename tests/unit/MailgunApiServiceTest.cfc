component extends="testbox.system.BaseSpec" {
	public function run(){
		describe( "isPostHookValid", function() {
			it( "should return true when generating a signature using passed token, timestamp and stored api key matches the provided signature", function(){
				var service = _getService();
				var timestamp = 1487089870;
				var token     = "9859b97624eb842a4a4463ff8138c5b412a086f33569fcb54b";
				var signature = "b1b54e561291204fd87e132d5ed99c923c79dfbd8651190f1aed6934efb3931b";
				var apiKey    = "key-9jlk309mslkjkjfl4099-sdkj59a-99n";

				service.$( "_getApiKey", apiKey );

				expect( service.isPostHookValid(
					  timestamp = timestamp
					, token     = token
					, signature = signature
				) ).toBeTrue();
			} );

			it( "should return false when generating a signature using passed token, timestamp and stored api key does not match the provided signature", function(){
				var service = _getService();
				var timestamp = 1487089870;
				var token     = "9859b97624eb842a4a4463ff8138c5b412a086f33569fcb54b";
				var signature = "2b6a49bb9ca653337599a9197919ebb3b8539c100d917be810a92d9bd112d58d";
				var apiKey    = "key-9jlk309mslkjkjfl4099-sdkj59a-99n";

				service.$( "_getApiKey", apiKey );

				expect( service.isPostHookValid(
					  timestamp = timestamp
					, token     = token
					, signature = signature
				) ).toBeFalse();
			} );
		});
	}

// private helpers
	private any function _getService() {
		variables.mockEmailServiceProviderService = CreateStub();

		var service = new mailgun.services.MailgunApiService(
			emailServiceProviderService = mockEmailServiceProviderService
		);

		service = createMock( object=service );

		return service;
	}
}