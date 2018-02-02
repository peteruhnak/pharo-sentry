tests
testAsDictionary
	event := self sampleEvent.
	self
		assert: event asDictionary
		equals:
			{'event_id' -> '12345678123412341234123456789012'.
			'timestamp' -> '2012-12-20T14:20:21'.
			'level' -> #warning.
			'logger' -> Sentry sdkName.
			'environment' -> 'testing'.
			'extra' -> {'a' -> 1} asDictionary.
			'platform' -> 'other'.
			'sdk'
				->
					{'name' -> Sentry sdkName.
					'version' -> Sentry sdkVersion} asDictionary} asDictionary