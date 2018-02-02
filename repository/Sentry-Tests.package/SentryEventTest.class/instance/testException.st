tests
testException
	event := self sampleEvent.
	event
		exception:
			(SentryException
				value:
					(SentryExceptionValue new
						type: 'ZeroDivide';
						value: 'Zero Division';
						module: 'Kernel')).
	self
		assert: (event asDictionary at: 'exception')
		equals:
			{{'type' -> 'ZeroDivide'.
			'value' -> 'Zero Division'.
			'module' -> 'Kernel'} asDictionary}