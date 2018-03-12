tests - validation
testValidateDsn
	self
		shouldnt: [ client validateDsn: 'https://public:secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'public:secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'https://secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'https://secret@sentry.example.com/' asZnUrl ]
		raise: AssertionFailure