sending
processException: anException
	Sentry showNotification
		ifFalse: [ ^ self ].
	(anException isKindOf: ConnectionTimedOut)
		ifTrue: [ ^ self inform: 'Connecting to logging server timed out.' ].
	self inform: 'Logging the error to remote server failed (no connection?).'