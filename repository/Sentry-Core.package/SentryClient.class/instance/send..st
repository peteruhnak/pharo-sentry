sending
send: anEvent
	self isEnabled
		ifFalse: [ ^ nil ].
	self assert: [ dsn isNotNil ] description: 'DSN wasn''t configured.'.
	beforeSend value: anEvent.
	self transport send: anEvent asDictionary to: dsn.
	^ anEvent eventId