serializing
serializeExceptionSignal: anExceptionSignal logger: aLogger
	| event exception |
	exception := anExceptionSignal exception.
	event := self eventFor: anExceptionSignal.
	event message: exception description.
	event
		exception:
			(SentryException new
				values:
					{SentryExceptionValue new
						type: exception class name;
						value: exception messageText;
						module: exception class package name;
						stacktrace: (self stacktraceFor: anExceptionSignal stack)}).
	^ event