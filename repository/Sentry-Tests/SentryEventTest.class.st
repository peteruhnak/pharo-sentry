Class {
	#name : #SentryEventTest,
	#superclass : #TestCase,
	#instVars : [
		'event'
	],
	#category : 'Sentry-Tests'
}

{ #category : #'instance creation' }
SentryEventTest >> sampleEvent [
	^ SentryEvent new
		eventId: (UUID fromString: '12345678-1234-1234-1234-123456789012');
		timestamp: '2012-12-20T15:20:21+01:00' asDateAndTime;
		level: #warning;
		environment: 'testing';
		extra: {'a' -> 1} asDictionary;
		yourself
]

{ #category : #running }
SentryEventTest >> setUp [
	super setUp.
	event := SentryEvent new
]

{ #category : #tests }
SentryEventTest >> testAsDictionary [
	event := self sampleEvent.
	self
		assert: event asDictionary
		equals:
			{'event_id' -> '12345678123412341234123456789012'.
			'timestamp' -> '2012-12-20T14:20:21'.
			'level' -> #warning.
			'logger' -> Sentry sdkName.
			'environment' -> 'testing'.
			'extra' -> {'a' -> 1} asDictionary.
			'platform' -> 'other'.
			'sdk'
				->
					{'name' -> Sentry sdkName.
					'version' -> Sentry sdkVersion} asDictionary.
			'contexts'
				->
					{'runtime'
						->
							{'name' -> 'Pharo'.
							'version' -> SystemVersion current highestUpdate} asDictionary} asDictionary}
				asDictionary
]

{ #category : #tests }
SentryEventTest >> testException [
	event := self sampleEvent.
	event
		exception:
			(SentryException
				value:
					(SentryExceptionValue new
						type: 'ZeroDivide';
						value: 'Zero Division';
						module: 'Kernel')).
	self
		assert: (event asDictionary at: 'exception')
		equals:
			{{'type' -> 'ZeroDivide'.
			'value' -> 'Zero Division'.
			'module' -> 'Kernel'} asDictionary}
]

{ #category : #tests }
SentryEventTest >> testIsoTimestampFor [
	self
		assert: (event isoTimestampFor: '2012-12-20T15:20:21+01:00' asDateAndTime)
		equals: '2012-12-20T14:20:21'
]

{ #category : #tests }
SentryEventTest >> testMessage [
	event := self sampleEvent.
	event message: 'hello'.
	self assert: (event asDictionary at: 'message') equals: 'hello'.
	self deny: (event asDictionary includesKey: 'sentry.interfaces.Message')
]

{ #category : #tests }
SentryEventTest >> testMessageComplex [
	event := self sampleEvent.
	event message: (SentryMessage message: 'hello %s' params: #('world')).
	self
		assert: (event asDictionary at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello %s'.
			'params' -> #('world')} asDictionary.
	self deny: (event asDictionary includesKey: 'message')
]

{ #category : #tests }
SentryEventTest >> testUUIDFor [
	self
		assert: (event uuid32For: (UUID fromString: '12345678-1234-1234-1234-123456789012'))
		equals: '12345678123412341234123456789012'
]
