initialization
initialize
	super initialize.
	eventId := UUID new.
	timestamp := DateAndTime now.
	logger := Sentry sdkName.
	platform := 'other'.
	sdk := {'name' -> Sentry sdkName.
	'version' -> Sentry sdkVersion} asDictionary.
	tags := Dictionary new