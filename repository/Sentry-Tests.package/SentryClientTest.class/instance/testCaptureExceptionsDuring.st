tests
testCaptureExceptionsDuring
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureExceptionsDuring: [ Error signal: 'msg' ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty