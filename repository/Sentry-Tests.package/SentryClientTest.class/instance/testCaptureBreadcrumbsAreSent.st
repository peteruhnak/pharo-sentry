tests
testCaptureBreadcrumbsAreSent
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		captureBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	client sendSampleMessage.
	self assert: ((data at: 'breadcrumbs') first at: 'message') equals: 'hello'