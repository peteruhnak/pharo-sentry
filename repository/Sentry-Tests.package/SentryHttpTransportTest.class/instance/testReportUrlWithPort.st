tests
testReportUrlWithPort
	| result |
	result := transport reportUrlFor: 'https://secret@sentry.example.com:9000/1' asZnUrl.
	self assert: result asString equals: 'https://sentry.example.com:9000/api/1/store/'