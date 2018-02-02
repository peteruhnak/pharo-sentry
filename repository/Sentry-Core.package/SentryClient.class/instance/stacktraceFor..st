extraction
stacktraceFor: anException
	| frames |
	frames := anException signalerContext stack
		collect: [ :context | 
			| method interval |
			method := context method.
			interval := context debuggerMap rangeForPC: context pc.
			SentryFrame new
				method: method;
				code: context sourceCode start: interval first;
				inApp: (self isMethodInApp: method) ].
	^ SentryStacktrace new frames: frames reversed asArray