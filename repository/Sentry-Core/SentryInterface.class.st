Class {
	#name : #SentryInterface,
	#superclass : #Object,
	#category : 'Sentry-Core-Model'
}

{ #category : #converting }
SentryInterface >> asDictionary [
	^ self subclassResponsibility
]

{ #category : #converting }
SentryInterface >> asDictionary: keys [
	^ SentryConverter new asDictionary: self keys: keys
]

{ #category : #converting }
SentryInterface >> asDictionary: keys optional: optionalKeys [
	^ SentryConverter new asDictionary: self keys: keys optional: optionalKeys
]
