"
The breadcrumbs interface specifies a series of application events, or “breadcrumbs”, that occurred before the main event.

https://docs.sentry.io/clientdev/interfaces/breadcrumbs/
"
Class {
	#name : #SentryBreadcrumb,
	#superclass : #SentryInterface,
	#instVars : [
		'timestamp',
		'type',
		'message',
		'data',
		'category',
		'level'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #converting }
SentryBreadcrumb >> asDictionary [
	^ {'timestamp' -> (self isoTimestampFor: self timestamp)} asDictionary
		, (self asDictionary: #(category) optional: #(type message data level))
]

{ #category : #accessing }
SentryBreadcrumb >> category [
	^ category
]

{ #category : #accessing }
SentryBreadcrumb >> category: anObject [
	category := anObject
]

{ #category : #accessing }
SentryBreadcrumb >> data [
	^ data
]

{ #category : #accessing }
SentryBreadcrumb >> data: anObject [
	data := anObject
]

{ #category : #initialization }
SentryBreadcrumb >> initialize [
	super initialize.
	timestamp := DateAndTime now
]

{ #category : #formatting }
SentryBreadcrumb >> isoTimestampFor: aDateTime [
	| utc |
	utc := aDateTime asUTC.
	^ String
		streamContents: [ :aStream | 
			utc printYMDOn: aStream withLeadingSpace: false.
			aStream nextPut: $T.
			utc printHMSOn: aStream ]
]

{ #category : #accessing }
SentryBreadcrumb >> level [
	^ level
]

{ #category : #accessing }
SentryBreadcrumb >> level: anObject [
	level := anObject
]

{ #category : #accessing }
SentryBreadcrumb >> message [
	^ message
]

{ #category : #accessing }
SentryBreadcrumb >> message: anObject [
	message := anObject
]

{ #category : #accessing }
SentryBreadcrumb >> timestamp [
	^ timestamp
]

{ #category : #accessing }
SentryBreadcrumb >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
SentryBreadcrumb >> type [
	^ type
]

{ #category : #accessing }
SentryBreadcrumb >> type: anObject [
	type := anObject
]
