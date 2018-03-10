tests
testCaptureBreadcrumbsAreCleanedUp
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		captureBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	self deny: client breadcrumbs isEmpty.
	client sendSampleMessage.
	self assert: client breadcrumbs isEmpty