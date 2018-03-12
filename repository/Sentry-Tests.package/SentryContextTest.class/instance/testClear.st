running
testClear
	context user: {'id' -> '123'}.
	context clear.
	self assert: context user equals: {} asDictionary