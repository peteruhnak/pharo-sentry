"
I serialize captured signals into a format acceptable by sentry.io and dispatch to the configured server.


SentryLogger start.
StringSignal emit: 'test'.
SentryLogger stop.


SentryLogger new runDuring: [
	[ 1/0 ] on: Exception do: [ :ex | ex emit ]
].
"
Class {
	#name : #SentryLogger,
	#superclass : #SerializingLogger,
	#category : 'Sentry-Beacon'
}

{ #category : #defaults }
SentryLogger class >> defaultSerializer [

	^ SentrySignalSerializer new
]

{ #category : #operations }
SentryLogger >> nextPutSerialized: aSentryEvent [
	Sentry default send: aSentryEvent
]
