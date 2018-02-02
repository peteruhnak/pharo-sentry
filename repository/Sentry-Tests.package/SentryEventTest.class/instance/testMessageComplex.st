tests
testMessageComplex
	event := self sampleEvent.
	event message: (SentryMessage message: 'hello %s' params: #('world')).
	self
		assert: (event asDictionary at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello %s'.
			'params' -> #('world')} asDictionary.
	self deny: (event asDictionary includesKey: 'message')