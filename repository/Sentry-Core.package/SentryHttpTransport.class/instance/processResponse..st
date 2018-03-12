sending
processResponse: aResponse
	Sentry showNotification & enableNotifications
		ifFalse: [ ^ self ].
	aResponse isSuccess
		ifTrue: [ ^ self inform: 'Error report sent.' ].
	self
		inform:
			'Failed to send error report.' , String cr , '[' , aResponse code asString , '] '
				, (aResponse headers at: 'X-Sentry-Error' ifAbsent: [ '' ])