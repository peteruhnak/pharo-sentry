tests - accessing
testDsnDisabled
	client dsn: ''.
	self deny: client isEnabled.
	client dsn: 'https://a:b@c/1'.
	self assert: client isEnabled