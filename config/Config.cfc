component {

	public void function configure( required struct config ) {
		_setupServiceProvider( arguments.config.settings ?: {} );
		_enableTls1_2();
	}

	private void function _setupServiceProvider( settings ) {
		settings.email.serviceProviders.mailgun = {};
	}

	private void function _enableTls1_2() {
		CreateObject("java", "java.lang.System").setProperty( "mail.smtp.ssl.protocols", "TLSv1.2");
	}

}
