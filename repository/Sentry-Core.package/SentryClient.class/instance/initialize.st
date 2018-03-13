initialization
initialize
	super initialize.
	dsn := ''.
	context := SentryContext new.
	appPackages := #().
	self resetBreadcrumbs.
	isInApp := [ :aMethod | 
	self appPackages isString
		ifTrue: [ self appPackages asRegex search: aMethod methodClass package name ]
		ifFalse: [ self appPackages includes: aMethod methodClass package ] ].
	beforeSend := [ :anEvent |  ]