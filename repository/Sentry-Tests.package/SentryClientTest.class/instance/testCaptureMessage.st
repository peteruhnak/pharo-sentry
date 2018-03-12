tests - capturing
testCaptureMessage
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello'.
	self assert: (data at: 'message') equals: 'hello'