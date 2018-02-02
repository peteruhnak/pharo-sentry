tests
testMessage
	event := self sampleEvent.
	event message: 'hello'.
	self assert: (event asDictionary at: 'message') equals: 'hello'.
	self deny: (event asDictionary includesKey: 'sentry.interfaces.Message')