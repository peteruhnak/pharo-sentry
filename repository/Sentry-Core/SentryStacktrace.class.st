Class {
	#name : #SentryStacktrace,
	#superclass : #SentryInterface,
	#instVars : [
		'frames',
		'framesOmitted'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #converting }
SentryStacktrace >> asDictionary [
	^ {'frames' -> (self frames collect: #asDictionary)} asDictionary
		, (self asDictionary: #() optional: #(frames_omitted))
]

{ #category : #accessing }
SentryStacktrace >> frames [
	^ frames
]

{ #category : #accessing }
SentryStacktrace >> frames: anObject [
	frames := anObject
]

{ #category : #accessing }
SentryStacktrace >> framesOmitted [
	^ framesOmitted
]

{ #category : #accessing }
SentryStacktrace >> framesOmitted: anObject [
	framesOmitted := anObject
]
