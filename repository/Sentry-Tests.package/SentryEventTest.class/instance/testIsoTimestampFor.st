tests
testIsoTimestampFor
	self
		assert: (event isoTimestampFor: '2012-12-20T15:20:21+01:00' asDateAndTime)
		equals: '2012-12-20T14:20:21'