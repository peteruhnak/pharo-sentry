tests - capturing
testCaptureMessageIn
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' in: [:event | event logger: 'dummy' ].
	self assert: (data at: 'message') equals: 'hello'.
	self assert: (data at: 'logger') equals: 'dummy'.