tests - breadcrumbs
testBreadcrumbsAreSent
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		recordBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	client sendSampleMessage.
	self assert: ((data at: 'breadcrumbs') first at: 'message') equals: 'hello'