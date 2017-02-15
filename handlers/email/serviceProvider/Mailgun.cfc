/**
 * Service provider for email sending through Mailgun API
 *
 */
component {
	property name="mailgunApiService" inject="mailgunApiService";
	property name="emailTemplateService" inject="emailTemplateService";

	private boolean function send( struct sendArgs={}, struct settings={} ) {
		var template            = emailTemplateService.getTemplate( sendArgs.template ?: "" );
		var tags                = [];
		var attachments         = sendArgs.attachments ?: [];
		var mgAttachments       = [];
		var attachmentsToRemove = [];

		if ( Len( Trim( template.name ?: "" ) ) ) {
			tags.append( template.name );
		}
		for( var attachment in attachments ) {
			var md5sum   = Hash( attachment.binary );
			var tmpDir   = getTempDirectory() & md5sum & "/";
			var filePath = tmpDir & attachment.name
			if ( !IsBoolean( attachment.removeAfterSend ?: "" ) || attachment.removeAfterSend ) {
				attachmentsToRemove.append( filePath );
			}

			if ( !FileExists( filePath ) ) {
				DirectoryCreate( tmpDir, true, true );
				FileWrite( filePath, attachment.binary );
			}

			mgAttachments.append( filePath );
		}
		var messageId = mailgunApiService.sendMessage(
			  from            = sendArgs.from
			, to              = sendArgs.to.toList( ";" )
			, subject         = sendArgs.subject
			, text            = sendArgs.textBody
			, html            = sendArgs.htmlBody
			, cc              = sendArgs.cc.toList( ";" )
			, bcc             = sendArgs.bcc.toList( ";" )
			, customVariables = { presideMessageId = sendArgs.messageId }
			, tags            = tags
			, attachments     = mgAttachments
		);

		for( var fileToRemove in attachmentsToRemove ) {
			try {
				FileDelete( fileToRemove );
			} catch ( any e ) {
				$raiseError( e );
			}
		}

		return messageId.len() > 0;
	}

	private any function validateSettings( required struct settings, required any validationResult ) {
		return validationResult;
	}
}