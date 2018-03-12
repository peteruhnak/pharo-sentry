running
testAsDictionary
	context user: {'id' -> '123'}.
	self
		assert: context asDictionary
		equals: {'user' -> {'id' -> '123'} asDictionary} asDictionary