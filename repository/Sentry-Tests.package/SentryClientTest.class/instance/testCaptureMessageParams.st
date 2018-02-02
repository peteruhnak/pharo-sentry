tests
testCaptureMessageParams
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' params: #(a b).
	self
		assert: (data at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello'.
			'params' -> #(a b)} asDictionary