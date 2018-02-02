tests
testFiletreeFileName
	self
		assert: (SentryFrame new filetreeFileNameFor: SentryClient >> #dsn:)
		equals: 'Sentry-Core.package/SentryClient.class/instance/dsn..st'.
	self
		assert: (SentryFrame new filetreeFileNameFor: SentryClient class >> #dsn:)
		equals: 'Sentry-Core.package/SentryClient.class/class/dsn..st'