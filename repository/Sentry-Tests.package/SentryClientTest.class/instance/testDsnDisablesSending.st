tests
testDsnDisablesSending
	| sent |
	sent := false.
	client transport: (SentryDummyTransport new onSend: [ :dict :dsn | sent := true ]).
	client dsn: ''.
	client send: (SentryEvent new).
	self deny: sent.