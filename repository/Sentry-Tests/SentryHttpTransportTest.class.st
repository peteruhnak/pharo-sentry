Class {
	#name : #SentryHttpTransportTest,
	#superclass : #TestCase,
	#instVars : [
		'transport'
	],
	#category : 'Sentry-Tests'
}

{ #category : #running }
SentryHttpTransportTest >> setUp [
	super setUp.
	transport := SentryHttpTransport new.
]

{ #category : #tests }
SentryHttpTransportTest >> testReportUrl [
	| result |
	result := transport reportUrlFor: 'https://secret@sentry.example.com/1' asZnUrl.
	self assert: result asString equals: 'https://sentry.example.com/api/1/store/'
]

{ #category : #tests }
SentryHttpTransportTest >> testReportUrlWithPort [
	| result |
	result := transport reportUrlFor: 'https://secret@sentry.example.com:9000/1' asZnUrl.
	self assert: result asString equals: 'https://sentry.example.com:9000/api/1/store/'
]
