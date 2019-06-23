Class {
	#name : #SentryExceptionValue,
	#superclass : #SentryInterface,
	#instVars : [
		'type',
		'value',
		'module',
		'stacktrace'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #converting }
SentryExceptionValue >> asDictionary [
	^ super asDictionary: #(type value module) optional: #(stacktrace)
]

{ #category : #accessing }
SentryExceptionValue >> module [
	^ module
]

{ #category : #accessing }
SentryExceptionValue >> module: anObject [
	module := anObject
]

{ #category : #accessing }
SentryExceptionValue >> stacktrace [
	^ stacktrace
]

{ #category : #accessing }
SentryExceptionValue >> stacktrace: anObject [
	stacktrace := anObject
]

{ #category : #accessing }
SentryExceptionValue >> type [
	^ type
]

{ #category : #accessing }
SentryExceptionValue >> type: anObject [
	type := anObject
]

{ #category : #accessing }
SentryExceptionValue >> value [
	^ value
]

{ #category : #accessing }
SentryExceptionValue >> value: anObject [
	value := anObject
]
