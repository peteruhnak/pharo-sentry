Class {
	#name : #SentryBreadcrumbTest,
	#superclass : #TestCase,
	#category : 'Sentry-Tests'
}

{ #category : #tests }
SentryBreadcrumbTest >> testAsDictionary [
	self
		assert:
			(SentryBreadcrumb new
				timestamp: '2012-12-20T15:20:21+01:00' asDateAndTime;
				category: 'test.example';
				type: 'default';
				message: 'Hello';
				data: {'a' -> 1} asDictionary;
				level: #warning) asDictionary
		equals:
			{'timestamp' -> '2012-12-20T14:20:21'.
			'category' -> 'test.example'.
			'type' -> 'default'.
			'message' -> 'Hello'.
			'data' -> {'a' -> 1} asDictionary.
			'level' -> #warning} asDictionary
]
