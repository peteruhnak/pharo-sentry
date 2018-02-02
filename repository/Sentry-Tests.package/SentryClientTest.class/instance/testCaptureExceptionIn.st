tests
testCaptureExceptionIn
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | client captureException: ex in: [ :event | event logger: 'dummy' ] ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty.
	self assert: (data at: 'logger') equals: 'dummy'