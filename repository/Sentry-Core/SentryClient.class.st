"
I am a client on which one dispatches exceptions and messages.

Normally I shouldn't be used directly, but as an endpoint for a regular logging framework, such as Beacon (see SentryLogger).
"
Class {
	#name : #SentryClient,
	#superclass : #Object,
	#instVars : [
		'dsn',
		'context',
		'breadcrumbs',
		'appPackages',
		'isInApp',
		'beforeSend',
		'transport',
		'lastEvent'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #'instance creation' }
SentryClient class >> dsn: aDsn [
	^ self new
		dsn: aDsn;
		yourself
]

{ #category : #accessing }
SentryClient >> appPackages [
	^ appPackages
]

{ #category : #accessing }
SentryClient >> appPackages: aCollection [
	appPackages := aCollection
]

{ #category : #accessing }
SentryClient >> beforeSend: aOneArgBlock [
	beforeSend := aOneArgBlock
]

{ #category : #accessing }
SentryClient >> breadcrumbs [
	^ breadcrumbs
]

{ #category : #capturing }
SentryClient >> captureException: anException [
	^ self captureException: anException in: [ :event |  ]
]

{ #category : #capturing }
SentryClient >> captureException: anException in: anEventBlock [
	| event |
	event := SentryEvent new.
	event message: anException description.
	event
		exception:
			(SentryException new
				values:
					{SentryExceptionValue new
						type: anException class name;
						value: anException messageText;
						module: anException class package name;
						stacktrace: (self stacktraceFor: anException)}).
	anEventBlock value: event.
	^ self send: event
]

{ #category : #capturing }
SentryClient >> captureExceptionsDuring: aBlock [
	self captureExceptionsDuring: aBlock in: [ :event | ]
]

{ #category : #capturing }
SentryClient >> captureExceptionsDuring: aBlock in: anEventBlock [
	aBlock
		on: Exception
		do: [ :err | self captureException: err in: anEventBlock ]
]

{ #category : #capturing }
SentryClient >> captureMessage: aString [
	^ self captureMessage: aString in: [ :event | ]
]

{ #category : #capturing }
SentryClient >> captureMessage: aString in: anEventBlock [
	| event |
	event := SentryEvent new.
	event message: aString.
	anEventBlock value: event.
	^ self send: event
]

{ #category : #capturing }
SentryClient >> captureMessage: aString params: aCollection [
	^ self captureMessage: aString params: aCollection in: [ :event |  ]
]

{ #category : #capturing }
SentryClient >> captureMessage: aString params: aCollection in: anEventBlock [
	| event |
	event := SentryEvent new.
	event message: (SentryMessage message: aString params: aCollection).
	anEventBlock value: event.
	^ self send: event
]

{ #category : #accessing }
SentryClient >> clearLastEvent [
	lastEvent := nil
]

{ #category : #accessing }
SentryClient >> context [
	^ context
]

{ #category : #accessing }
SentryClient >> defaultTransport [
	^ SentryHttpTransport new
]

{ #category : #accessing }
SentryClient >> dsn [
	^ dsn
]

{ #category : #accessing }
SentryClient >> dsn: aDsn [
	| dsnUrl |
	dsnUrl := aDsn asZnUrl.
	self validateDsn: dsnUrl.
	dsn := dsnUrl
]

{ #category : #accessing }
SentryClient >> dsnString [
	^ dsn asString
]

{ #category : #initialization }
SentryClient >> initialize [
	super initialize.
	dsn := ''.
	context := SentryContext new.
	appPackages := #().
	self resetBreadcrumbs.
	isInApp := [ :aMethod | 
	self appPackages isString
		ifTrue: [ self appPackages asRegex search: aMethod methodClass package name ]
		ifFalse: [ self appPackages includes: aMethod methodClass package ] ].
	beforeSend := [ :anEvent |  ]
]

{ #category : #testing }
SentryClient >> isEnabled [
	^ dsn isEmpty not & Sentry enabled
]

{ #category : #testing }
SentryClient >> isMethodInApp: aMethod [
	^ isInApp value: aMethod
]

{ #category : #accessing }
SentryClient >> lastEvent [
	^ lastEvent
]

{ #category : #capturing }
SentryClient >> recordBreadcrumbIn: aOneArgBlock [
	| crumb |
	crumb := SentryBreadcrumb new.
	aOneArgBlock value: crumb.
	breadcrumbs add: crumb
]

{ #category : #initialization }
SentryClient >> resetBreadcrumbs [
	breadcrumbs := OrderedCollection new
]

{ #category : #sending }
SentryClient >> send: anEvent [
	| payload |
	self isEnabled
		ifFalse: [ ^ nil ].
	self assert: [ dsn isNotNil ] description: 'DSN wasn''t configured.'.
	beforeSend value: anEvent.
	payload := anEvent asDictionary.
	breadcrumbs
		ifNotEmpty: [ payload at: 'breadcrumbs' put: (breadcrumbs collect: #asDictionary) asArray.
			self resetBreadcrumbs ].
	context asDictionary ifNotEmpty: [ :ctx | payload := payload , ctx ].
	self transport send: payload to: dsn.
	lastEvent := anEvent.
	^ anEvent eventId
]

{ #category : #examples }
SentryClient >> sendSampleException [
	^ [ self error: 'Sample Exception' ]
		on: Exception
		do: [ :ex | self captureException: ex in: [ :event | event level: 'sample' ] ]
]

{ #category : #examples }
SentryClient >> sendSampleMessage [
	self captureMessage: 'Sample Message' in: [ :event | event level: 'sample' ]
]

{ #category : #extraction }
SentryClient >> stacktraceFor: anException [
	| frames |
	frames := anException signalerContext stack
		collect: [ :ctx | 
			| method interval |
			method := ctx method.
			interval := ctx debuggerMap rangeForPC: ctx pc.
			SentryFrame new
				method: method;
				code: ctx sourceCode start: interval first;
				inApp: (self isMethodInApp: method);
				vars:
					{'_receiver' -> (ctx receiver printStringLimitedTo: 120).
					'_context' -> (ctx printStringLimitedTo: 120)} asDictionary ].
	^ SentryStacktrace new frames: frames reversed asArray
]

{ #category : #accessing }
SentryClient >> transport [
	^ transport ifNil: [ transport := self defaultTransport ]
]

{ #category : #accessing }
SentryClient >> transport: aTransport [
	transport := aTransport
]

{ #category : #validation }
SentryClient >> validateDsn: aDsn [
	"scheme://username:password@host/path"

	"Empty DSN disables the client."

	aDsn isEmpty ifTrue: [ ^ self ].
	self
		assert: [ aDsn scheme isNotNil and: [ aDsn scheme isNotEmpty ] ]
		description: 'scheme is missing in the DSN'.
	self
		assert: [ aDsn username isNotNil and: [ aDsn username isNotEmpty ] ]
		description: 'username is missing in the DSN'.
	self
		assert: [ aDsn password isNotNil and: [ aDsn password isNotEmpty ] ]
		description: 'password is missing in the DSN'.
	self
		assert: [ aDsn host isNotNil and: [ aDsn host isNotEmpty ] ]
		description: 'host is missing in the DSN'.
	self
		assert: [ aDsn path isNotNil and: [ aDsn path isNotEmpty ] ]
		description: 'path is missing in the DSN'
]
