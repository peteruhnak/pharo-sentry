running
testAsDictionary
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	self
		assert: context asDictionary
		equals:
			{'release' -> 'v0.9.0'.
			'user' -> {'id' -> '123'} asDictionary} asDictionary