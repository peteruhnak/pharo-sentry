accessing
transport
	^ transport ifNil: [ transport := self defaultTransport ]