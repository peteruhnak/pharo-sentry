tests
testCaptureBreadcrumbIn
	client captureBreadcrumbIn: [ :crumb | crumb message: 'hello' ].
	self assert: (client breadcrumbs collect: #message) asArray equals: #('hello')