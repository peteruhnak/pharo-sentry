settings
dsn
	^ self default dsn isEmpty ifTrue: [ '' ] ifFalse: [ self default dsn asString ]