instance creation
sampleEvent
	^ SentryEvent new
		eventId: (UUID fromString: '12345678-1234-1234-1234-123456789012');
		timestamp: '2012-12-20T15:20:21+01:00' asDateAndTime;
		level: #warning;
		environment: 'testing';
		extra: {'a' -> 1} asDictionary;
		yourself