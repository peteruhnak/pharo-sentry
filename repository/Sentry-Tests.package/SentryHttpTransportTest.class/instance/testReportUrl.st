tests
testReportUrl
	| result |
	result := transport reportUrlFor: 'https://secret@sentry.example.com/1' asZnUrl.
	self assert: result asString equals: 'https://sentry.example.com/api/1/store/'