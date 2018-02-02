running
setUp
	super setUp.
	client := SentryClient new dsn: 'https://username:secret@localhost/1'.
	client transport: SentryDummyTransport new