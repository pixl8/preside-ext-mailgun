/**
 * Service provider for email sending through Mailgun API
 *
 */
component {
	property name="mailgunApiService" inject="mailgunApiService";

	private boolean function send( struct sendArgs={}, struct settings={} ) {
		var messageId = mailgunApiService.sendMessage(
				from            = sendArgs.from
			  , to              = sendArgs.to.toList( ";" )
			  , subject         = sendArgs.subject
			  , text            = sendArgs.textBody
			  , html            = sendArgs.htmlBody
			  , cc              = sendArgs.cc.toList( ";" )
			  , bcc             = sendArgs.bcc.toList( ";" )
			  , customVariables = { presideMessageId = sendArgs.messageId }
		);

		return messageId.len() > 0;
	}

	private any function validateSettings( required struct settings, required any validationResult ) {
		return validationResult;
	}
}