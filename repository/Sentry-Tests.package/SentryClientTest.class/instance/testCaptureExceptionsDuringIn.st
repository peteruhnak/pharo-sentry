tests
testCaptureExceptionsDuringIn
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		captureExceptionsDuring: [ Error signal: 'msg' ]
		in: [ :event | event logger: 'dummy' ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty.
	self assert: (data at: 'logger') equals: 'dummy'