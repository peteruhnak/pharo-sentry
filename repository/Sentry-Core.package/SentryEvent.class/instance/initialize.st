initialization
initialize
	super initialize.
	eventId := UUID new.
	timestamp := DateAndTime now.
	logger := Sentry sdkName.
	platform := 'other'.
	sdk := {'name' -> Sentry sdkName.
	'version' -> Sentry sdkVersion} asDictionary.
	contexts := {'runtime'
		->
			{'name' -> 'Pharo'.
			'version' -> SystemVersion current highestUpdate} asDictionary} asDictionary.
	tags := Dictionary new