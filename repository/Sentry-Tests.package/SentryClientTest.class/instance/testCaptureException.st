tests - capturing
testCaptureException
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | client captureException: ex ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty