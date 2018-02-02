capturing
captureMessage: aString params: aCollection in: anEventBlock
	| event |
	event := SentryEvent new.
	event message: (SentryMessage message: aString params: aCollection).
	anEventBlock value: event.
	^ self send: event