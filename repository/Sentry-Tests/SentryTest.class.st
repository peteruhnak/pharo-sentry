Class {
	#name : #SentryTest,
	#superclass : #TestCase,
	#instVars : [
		'originalClient'
	],
	#category : 'Sentry-Tests'
}

{ #category : #running }
SentryTest >> setUp [
	originalClient := Sentry default.
	Sentry default: nil.
]

{ #category : #running }
SentryTest >> tearDown [
	originalClient := Sentry default.
	Sentry default: originalClient.
]
