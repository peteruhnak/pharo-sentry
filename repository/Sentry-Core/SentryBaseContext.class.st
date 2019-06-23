Class {
	#name : #SentryBaseContext,
	#superclass : #SentryInterface,
	#category : 'Sentry-Core-Model'
}

{ #category : #converting }
SentryBaseContext >> clear [
	self subclassResponsibility
]

{ #category : #converting }
SentryBaseContext >> merge: aCollectionOrContext [
	self subclassResponsibility
]
