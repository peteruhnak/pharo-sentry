validation
validateDsn: aDsn
	"scheme://username:password@host/path"

	"Empty DSN disables the client."

	aDsn isEmpty ifTrue: [ ^ self ].
	self
		assert: [ aDsn scheme isNotNil and: [ aDsn scheme isNotEmpty ] ]
		description: 'scheme is missing in the DSN'.
	self
		assert: [ aDsn username isNotNil and: [ aDsn username isNotEmpty ] ]
		description: 'username is missing in the DSN'.
	self
		assert: [ aDsn password isNotNil and: [ aDsn password isNotEmpty ] ]
		description: 'password is missing in the DSN'.
	self
		assert: [ aDsn host isNotNil and: [ aDsn host isNotEmpty ] ]
		description: 'host is missing in the DSN'.
	self
		assert: [ aDsn path isNotNil and: [ aDsn path isNotEmpty ] ]
		description: 'path is missing in the DSN'