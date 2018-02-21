accessing - special
requiredPayload
	^ {'event_id' -> self eventIdString.
	'timestamp' -> (self isoTimestampFor: self timestamp)} asDictionary