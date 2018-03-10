initialization
initialize
	super initialize.
	dsn := ''.
	appPackages := #().
	self resetBreadcrumbs.
	isInApp := [ :aMethod | 
	appPackages isString
		ifTrue: [ appPackages asRegex search: aMethod methodClass package name ]
		ifFalse: [ appPackages includes: aMethod methodClass package ] ].
	beforeSend := [ :anEvent |  ]