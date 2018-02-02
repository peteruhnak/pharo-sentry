tests
testTonelFileName
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient >> #dsn:)
		equals: 'Sentry-Core/SentryClient.class.st'.
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient class >> #dsn:)
		equals: 'Sentry-Core/SentryClient.class.st'