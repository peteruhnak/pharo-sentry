Class {
	#name : #SentryException,
	#superclass : #SentryInterface,
	#instVars : [
		'values'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #accessing }
SentryException class >> value: aValue [
	^ self new
		values: {aValue};
		yourself
]

{ #category : #converting }
SentryException >> asDictionary [
	^ values collect: #asDictionary
]

{ #category : #accessing }
SentryException >> values [
	^ values
]

{ #category : #accessing }
SentryException >> values: anObject [
	values := anObject
]
