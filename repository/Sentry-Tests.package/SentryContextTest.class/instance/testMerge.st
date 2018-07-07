running
testMerge
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	context
		merge:
			{'release' -> 'v0.9.1'.
			'user' -> {'email' -> 'me@example.com'} asDictionary}.
	self
		assert: context user
		equals:
			{'id' -> '123'.
			'email' -> 'me@example.com'} asDictionary.
	self assert: context release equals: 'v0.9.1'