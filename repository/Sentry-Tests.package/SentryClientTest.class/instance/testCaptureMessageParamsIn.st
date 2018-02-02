tests
testCaptureMessageParamsIn
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' params: #(a b) in: [ :event | event logger: 'dummy' ].
	self
		assert: (data at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello'.
			'params' -> #(a b)} asDictionary.
	self assert: (data at: 'logger') equals: 'dummy'