serializing
eventFor: aSignal
	^ SentryEvent new
		timestamp: aSignal timestamp;
		logger: 'beacon';
		level: aSignal level shortName;
		tags: (aSignal properties ifEmpty: [ nil ]);
		yourself