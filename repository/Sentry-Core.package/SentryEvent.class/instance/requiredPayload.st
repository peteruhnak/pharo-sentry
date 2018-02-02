accessing - special
requiredPayload
	^ {'event_id' -> (self uuid32For: self eventId).
	'timestamp' -> (self isoTimestampFor: self timestamp)} asDictionary