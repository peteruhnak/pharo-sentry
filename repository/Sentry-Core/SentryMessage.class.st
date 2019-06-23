Class {
	#name : #SentryMessage,
	#superclass : #SentryInterface,
	#instVars : [
		'message',
		'params',
		'formatted'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #'instance creation' }
SentryMessage class >> message: aString [
	^ self new
		message: aString;
		yourself
]

{ #category : #'instance creation' }
SentryMessage class >> message: aString params: aCollection [
	^ self new
		message: aString;
		params: aCollection;
		yourself
]

{ #category : #converting }
SentryMessage >> asDictionary [
	^ self asDictionary: #(message) optional: #(params formatted)
]

{ #category : #accessing }
SentryMessage >> formatted [
	^ formatted
]

{ #category : #accessing }
SentryMessage >> formatted: anObject [
	formatted := anObject
]

{ #category : #accessing }
SentryMessage >> message [
	^ message
]

{ #category : #accessing }
SentryMessage >> message: anObject [
	message := anObject
]

{ #category : #accessing }
SentryMessage >> params [
	^ params asArray
]

{ #category : #accessing }
SentryMessage >> params: anObject [
	params := anObject
]
