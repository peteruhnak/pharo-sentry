Class {
	#name : #SentryContextTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'context'
	],
	#category : 'Sentry-Tests'
}

{ #category : #running }
SentryContextTest >> setUp [
	super setUp.
	context := SentryContext new
]

{ #category : #running }
SentryContextTest >> testAsDictionary [
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	self
		assert: context asDictionary
		equals:
			{'release' -> 'v0.9.0'.
			'user' -> {'id' -> '123'} asDictionary} asDictionary
]

{ #category : #running }
SentryContextTest >> testClear [
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	context clear.
	self assert: context user equals: {} asDictionary.
	self assert: context release equals: nil
]

{ #category : #running }
SentryContextTest >> testMerge [
	context user: {'id' -> '123'}.
	context release: 'v0.9.0'.
	context
		merge:
			{'release' -> 'v0.9.1'.
			'user' -> {'email' -> 'me@example.com'} asDictionary}.
	self
		assert: context user
		equals:
			{'id' -> '123'.
			'email' -> 'me@example.com'} asDictionary.
	self assert: context release equals: 'v0.9.1'
]
