settings
settingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #sentry)
		parent: #privacy;
		label: 'Sentry Error Tracking';
		noOrdering;
		with: [ (aBuilder setting: #enabled)
				target: self;
				label: 'Enable Reporting';
				description: 'Enable submission to Sentry server.'.
			(aBuilder setting: #autoSubmit)
				target: self;
				label: 'Automatic Submission';
				description: 'Reports will be sent automatically without user confirmation.'.
			(aBuilder setting: #enableContextData)
				target: self;
				label: 'Send Context Data';
				description:
					'Enabling this will send context data (parameter values, etc.). Although helpful for debugging, such data can contain sensitive information.'.
			(aBuilder setting: #showNotification)
				target: self;
				label: 'Show Notifications';
				description: 'An unobtrusive notification will appear when an error has been sent.'.
			(aBuilder group: #sentrySettings)
				label: 'Sentry Settings';
				noOrdering;
				with: [ (aBuilder setting: #dsn)
						target: self;
						label: 'DSN';
						description: 'Default DSN settings';
						type: #String ] ]