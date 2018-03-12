tests - instance creation
testDsnCreate
	client := SentryClient dsn: self sampleDsn.
	self assert: client dsn equals: self sampleDsn asZnUrl