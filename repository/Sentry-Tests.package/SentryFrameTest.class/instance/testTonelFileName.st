tests
testTonelFileName
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient >> #dsn:)
		equals: 'Sentry/SentryClient.class.st'.
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient class >> #dsn:)
		equals: 'Sentry/SentryClient.class.st'