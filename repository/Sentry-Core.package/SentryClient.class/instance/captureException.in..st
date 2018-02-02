capturing
captureException: anException in: anEventBlock
	| event |
	event := SentryEvent new.
	event message: anException description.
	event
		exception:
			(SentryException new
				values:
					{SentryExceptionValue new
						type: anException class name;
						value: anException messageText;
						module: anException class package name;
						stacktrace: (self stacktraceFor: anException)}).
	anEventBlock value: event.
	^ self send: event