capturing
captureMessage: aString in: anEventBlock
	| event |
	event := SentryEvent new.
	event message: aString.
	anEventBlock value: event.
	^ self send: event