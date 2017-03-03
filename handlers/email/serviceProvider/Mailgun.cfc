/**
 * Service provider for email sending through Mailgun API
 *
 */
component {
	property name="mailgunApiService" inject="mailgunApiService";
	property name="emailTemplateService" inject="emailTemplateService";

	private boolean function send( struct sendArgs={}, struct settings={} ) {
		var template = emailTemplateService.getTemplate( sendArgs.template ?: "" );

		sendArgs.params = sendArgs.params ?: {};
		sendArgs.params[ "X-Mailgun-Variables" ] = {
			  name  = "X-Mailgun-Variables"
			, value =  SerializeJson( { presideMessageId = sendArgs.messageId ?: "" } )
		};

		if ( IsTrue( settings.mailgun_test_mode ?: "" ) ) {
			sendArgs.params[ "X-Mailgun-Drop-Message" ] = {
				  name  = "X-Mailgun-Drop-Message"
				, value =  "yes"
			};
		}
		if ( Len( Trim( template.name ?: "" ) ) ) {
			sendArgs.params[ "X-Mailgun-Tag" ] = {
				  name  = "X-Mailgun-Tag"
				, value =  template.name
			};
		}

		var result = runEvent(
			  event          = "email.serviceProvider.smtp.send"
			, private        = true
			, prepostExempt  = true
			, eventArguments = {
				  sendArgs = sendArgs
				, settings = settings
			  }
		);

		return result;
	}

	private any function validateSettings( required struct settings, required any validationResult ) {
		return validationResult;
	}
}