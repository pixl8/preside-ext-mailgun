component extends="testbox.system.BaseSpec" {
	public function run(){
		describe( "validatePostHookSignature", function() {
			it( "should return true when generating a signature using passed token, timestamp and stored api key matches the provided signature", function(){
				var service = _getService();
				var timestamp = 1487089870;
				var token     = "9859b97624eb842a4a4463ff8138c5b412a086f33569fcb54b";
				var signature = "b1b54e561291204fd87e132d5ed99c923c79dfbd8651190f1aed6934efb3931b";
				var apiKey    = "key-9jlk309mslkjkjfl4099-sdkj59a-99n";

				service.$( "_getApiKey", apiKey );

				expect( service.validatePostHookSignature(
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

				expect( service.validatePostHookSignature(
					  timestamp = timestamp
					, token     = token
					, signature = signature
				) ).toBeFalse();
			} );
		});

		describe( "getPresideMessageIdForNotification", function(){
			it( "should return the ID in 'presideMessageId' variable if found in POST data", function(){
				var service  = _getService();
				var postData = { test=CreateUUId(), presideMessageId=CreateUUId() };

				expect( service.getPresideMessageIdForNotification( postData ) ).toBe( postData.presideMessageId );
			} );

			it( "should return X-Message-ID mail header if 'presideMessageId' is not present", function(){
				var service = _getService();
				var messageId = CreateUUId();
				var postData = { test=CreateUUId(), "message-headers"='[["Sender", "test@preside.org"], ["Date", "Tue, 14 Feb 2017 16:31:10 +0000"], ["X-Mailgun-Sending-Ip", "184.173.153.222"], ["X-Mailgun-Sid", "WyI4ZDI4NyIsICJkb21pbmljLndhdHNvbkBwaXhsOC5jby51ayIsICIxMDljMCJd"], ["Received", "by luna.mailgun.net with HTTP; Tue, 14 Feb 2017 16:31:09 +0000"], ["Message-Id", "<20170214163109.97563.12188.A9321BA4@preside.org>"], ["X-Message-ID", "#messageId#"], ["To", "dominic.watson@pixl8.co.uk"], ["From", "test@preside.org"], ["Subject", "Mailgun test"], ["Mime-Version", "1.0"], ["Content-Type", ["multipart/alternative", {"boundary": "b6fc3745c8704ca8b0b839614e9d27be"}]]]'}

				expect( service.getPresideMessageIdForNotification( postData ) ).toBe( messageId );
			} );

			it( "should return X-Message-ID mail header if 'presideMessageId' is empty string", function(){
				var service = _getService();
				var messageId = CreateUUId();
				var postData = { test=CreateUUId(), presideMessageId="", "message-headers"='[["Sender", "test@preside.org"], ["Date", "Tue, 14 Feb 2017 16:31:10 +0000"], ["X-Mailgun-Sending-Ip", "184.173.153.222"], ["X-Mailgun-Sid", "WyI4ZDI4NyIsICJkb21pbmljLndhdHNvbkBwaXhsOC5jby51ayIsICIxMDljMCJd"], ["Received", "by luna.mailgun.net with HTTP; Tue, 14 Feb 2017 16:31:09 +0000"], ["Message-Id", "<20170214163109.97563.12188.A9321BA4@preside.org>"], ["X-Message-ID", "#messageId#"], ["To", "dominic.watson@pixl8.co.uk"], ["From", "test@preside.org"], ["Subject", "Mailgun test"], ["Mime-Version", "1.0"], ["Content-Type", ["multipart/alternative", {"boundary": "b6fc3745c8704ca8b0b839614e9d27be"}]]]'}

				expect( service.getPresideMessageIdForNotification( postData ) ).toBe( messageId );
			} );

			it( "should return empty string when neither X-Message-ID or presideMessageId present", function(){
				var service = _getService();
				var postData = { test=CreateUUId(), "message-headers"='[["Sender", "test@preside.org"], ["Date", "Tue, 14 Feb 2017 16:31:10 +0000"], ["X-Mailgun-Sending-Ip", "184.173.153.222"], ["X-Mailgun-Sid", "WyI4ZDI4NyIsICJkb21pbmljLndhdHNvbkBwaXhsOC5jby51ayIsICIxMDljMCJd"], ["Received", "by luna.mailgun.net with HTTP; Tue, 14 Feb 2017 16:31:09 +0000"], ["To", "dominic.watson@pixl8.co.uk"], ["From", "test@preside.org"], ["Subject", "Mailgun test"], ["Mime-Version", "1.0"], ["Content-Type", ["multipart/alternative", {"boundary": "b6fc3745c8704ca8b0b839614e9d27be"}]]]'}

				expect( service.getPresideMessageIdForNotification( postData ) ).toBe( "" );
			} );
		} );
	}

// private helpers
	private any function _getService() {
		variables.mockEmailServiceProviderService = CreateStub();

		var service = new mailgun.services.MailgunNotificationsService(
			emailServiceProviderService = mockEmailServiceProviderService
		);

		service = createMock( object=service );

		return service;
	}
}