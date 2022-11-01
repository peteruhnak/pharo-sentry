"
I hold all contextual information for the events.
"
Class {
	#name : #SentryContext,
	#superclass : #SentryBaseContext,
	#instVars : [
		'user',
		'request',
		'extra',
		'tags',
		'release'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #'accessing - special' }
SentryContext >> asDictionary [
	^ self asDictionary: #() optional: #(user release request extra tags)
]

{ #category : #initialization }
SentryContext >> clear [
	extra := {} asDictionary.
	request := {} asDictionary.
	user := {} asDictionary.
	tags := {} asDictionary.
	release := nil
]

{ #category : #accessing }
SentryContext >> extra [
	^ extra
]

{ #category : #accessing }
SentryContext >> extra: aCollection [
	extra := aCollection asDictionary
]

{ #category : #initialization }
SentryContext >> initialize [
	super initialize.
	self clear
]

{ #category : #merging }
SentryContext >> merge: aCollectionOrContext [
	aCollectionOrContext asDictionary
		keysAndValuesDo: [ :key :value | 
			value isString
				ifTrue: [ self perform: key asSymbol asMutator with: value ]
				ifFalse: [ self perform: key asSymbol asMutator with: (self perform: key asSymbol) , value ] ]
]

{ #category : #accessing }
SentryContext >> release [
	^ release
]

{ #category : #accessing }
SentryContext >> release: aRelease [
	release := aRelease
]

{ #category : #accessing }
SentryContext >> request [
	^ request
]

{ #category : #accessing }
SentryContext >> request: aCollection [
	request := aCollection asDictionary
]

{ #category : #accessing }
SentryContext >> tags [
	^ tags
]

{ #category : #accessing }
SentryContext >> tags: aCollection [
	tags := aCollection asDictionary
]

{ #category : #accessing }
SentryContext >> user [
	^ user
]

{ #category : #accessing }
SentryContext >> user: aCollection [
	"the base attributes are id, email, ip_address, and username"

	user := aCollection asDictionary
]
