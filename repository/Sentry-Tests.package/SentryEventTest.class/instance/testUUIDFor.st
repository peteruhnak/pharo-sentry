tests
testUUIDFor
	self
		assert: (event uuid32For: (UUID fromString: '12345678-1234-1234-1234-123456789012'))
		equals: '12345678123412341234123456789012'