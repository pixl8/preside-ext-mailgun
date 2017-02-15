component {

	property name="mailgunNotificationsService" inject="mailgunNotificationsService";

	public void function index( event, rc, prc ) {
		// deliberate use of form scope here. DO NOT CHANGE.
		// this is because 'event' is overridden in rc scope by coldbox
		var validRequest = mailgunNotificationsService.validatePostHookSignature(
			  timestamp = Val( form.timestamp ?: "" )
			, token     = form.token     ?: ""
			, signature = form.signature ?: ""
		);

		if ( validRequest ) {
			var presideMessageId = mailgunNotificationsService.getPresideMessageIdForNotification( form );

			if ( presideMessageId.trim().len() ) {
				var messageEvent = form.event ?: "";
				mailgunNotificationsService.processNotification(
					  messageId    = presideMessageId
					, messageEvent = messageEvent
					, formData     = form
				);
				event.renderData( type="text", data="Notification of [#messageEvent#] event received and processed for preside message [#presideMessageId#]", statuscode=200 );
			} else {
				event.renderData( type="text", data="Not acceptable: could not identify source preside message", statusCode=406 );
			}
		} else {
			event.renderData( type="text", data="Not acceptable: invalid request signature", statusCode=406 );
		}



	}

}