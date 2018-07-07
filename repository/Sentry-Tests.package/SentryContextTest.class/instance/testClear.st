running
testClear
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	context clear.
	self assert: context user equals: {} asDictionary.
	self assert: context release equals: nil