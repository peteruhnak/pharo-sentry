running
testMerge
	context user: {'id' -> '123'}.
	context merge: {'user' -> {'email' -> 'me@example.com'} asDictionary}.
	self
		assert: context user
		equals:
			{'id' -> '123'.
			'email' -> 'me@example.com'} asDictionary