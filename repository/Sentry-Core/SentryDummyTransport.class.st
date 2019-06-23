Class {
	#name : #SentryDummyTransport,
	#superclass : #SentryTransport,
	#instVars : [
		'onSend'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #initialization }
SentryDummyTransport >> initialize [
	super initialize.
	onSend := [ :dict :dsn | ]
]

{ #category : #accessing }
SentryDummyTransport >> onSend: aTwoArgBlock [
	onSend := aTwoArgBlock
]

{ #category : #sending }
SentryDummyTransport >> send: aDictionary to: aDsn [
	onSend value: aDictionary value: aDsn
]
