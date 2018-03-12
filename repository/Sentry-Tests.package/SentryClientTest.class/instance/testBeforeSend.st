tests - accessing
testBeforeSend
	| event |
	client transport: SentryDummyTransport new.
	client beforeSend: [ :ev | ev logger: 'dummy' ].
	event := SentryEvent new.
	client send: event.
	self assert: event logger equals: 'dummy'