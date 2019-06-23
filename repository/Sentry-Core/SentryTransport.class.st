Class {
	#name : #SentryTransport,
	#superclass : #Object,
	#category : 'Sentry-Core-Model'
}

{ #category : #sending }
SentryTransport >> send: aDictionary to: aDsn [
	self subclassResponsibility
]
