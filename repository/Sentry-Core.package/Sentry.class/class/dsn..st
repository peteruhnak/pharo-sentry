settings
dsn: aString
	"System Settings create an empty Object instead of an empty string for whatever reason."
	self default
		dsn:
			((aString isMemberOf: Object)
				ifTrue: [ '' ]
				ifFalse: [ aString ])