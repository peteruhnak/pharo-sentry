accessing
authHeaderFor: aDsn
	^ {'Sentry sentry_version=7'.
	'sentry_timestamp=' , DateAndTime now asUnixTime asString.
	'sentry_key=' , aDsn username.
	'sentry_secret=' , aDsn password.
	'sentry_client=' , Sentry sdkName , '/' , Sentry sdkVersion} joinUsing: ','