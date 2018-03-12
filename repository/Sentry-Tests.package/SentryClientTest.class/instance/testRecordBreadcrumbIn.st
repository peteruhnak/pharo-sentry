tests - breadcrumbs
testRecordBreadcrumbIn
	client recordBreadcrumbIn: [ :crumb | crumb message: 'hello' ].
	self assert: (client breadcrumbs collect: #message) asArray equals: #('hello')