settings
dsn: aString
	"System Settings create an empty Object instead of an empty string for whatever reason, so I need to make an explicit check"
	self default
		dsn:
			((aString isMemberOf: Object)
				ifTrue: [ '' ]
				ifFalse: [ aString ])