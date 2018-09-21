Class {
	#name : #SentrySignalSerializerTest,
	#superclass : #TestCase,
	#instVars : [
		'serializer'
	],
	#category : 'Sentry-Beacon-Tests'
}

{ #category : #running }
SentrySignalSerializerTest >> setUp [
	super setUp.
	serializer := SentrySignalSerializer new
]

{ #category : #testing }
SentrySignalSerializerTest >> testEventFor [
	| signal event |
	signal := StringSignal new
		level: LogLevel error;
		in: [ :sg | sg properties at: 'foo' put: 'bar' ];
		yourself.
	event := serializer eventFor: signal.
	self assert: event timestamp equals: signal timestamp.
	self assert: event level equals: 'error'.
	self assert: event tags equals: {'foo' -> 'bar'} asDictionary
]
