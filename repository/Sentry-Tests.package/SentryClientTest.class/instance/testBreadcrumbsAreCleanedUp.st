tests - breadcrumbs
testBreadcrumbsAreCleanedUp
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		recordBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	self deny: client breadcrumbs isEmpty.
	client sendSampleMessage.
	self assert: client breadcrumbs isEmpty