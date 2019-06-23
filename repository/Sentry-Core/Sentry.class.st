"
I am a facade for a global sentry client.
"
Class {
	#name : #Sentry,
	#superclass : #Object,
	#classInstVars : [
		'default',
		'autoSubmit',
		'enableContextData',
		'showNotification',
		'enabled'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #settings }
Sentry class >> autoSubmit [
	^ autoSubmit ifNil: [ autoSubmit := false ]
]

{ #category : #settings }
Sentry class >> autoSubmit: aBoolean [
	^ autoSubmit := aBoolean
]

{ #category : #accessing }
Sentry class >> client [
	^ self default
]

{ #category : #accessing }
Sentry class >> default [
	"
	default := nil
	"
	^ default ifNil: [ default := SentryClient new ]
]

{ #category : #accessing }
Sentry class >> default: aDefaultClient [
	^ default := aDefaultClient
]

{ #category : #settings }
Sentry class >> dsn [
	^ self default dsn isEmpty ifTrue: [ '' ] ifFalse: [ self default dsn asString ]
]

{ #category : #settings }
Sentry class >> dsn: aString [
	"System Settings create an empty Object instead of an empty string for whatever reason, so I need to make an explicit check"
	self default
		dsn:
			((aString isMemberOf: Object)
				ifTrue: [ '' ]
				ifFalse: [ aString ])
]

{ #category : #settings }
Sentry class >> enableContextData [
	^ enableContextData ifNil: [ enableContextData := false ]
]

{ #category : #settings }
Sentry class >> enableContextData: aBoolean [
	^ enableContextData := aBoolean
]

{ #category : #settings }
Sentry class >> enabled [
	^ enabled ifNil: [ enabled := true ]
]

{ #category : #settings }
Sentry class >> enabled: aBoolean [
	enabled := aBoolean
]

{ #category : #accessing }
Sentry class >> sdkName [
	^ 'sentry-pharo'
]

{ #category : #accessing }
Sentry class >> sdkVersion [
	^ '0.1.0'
]

{ #category : #settings }
Sentry class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #sentry)
		parent: #privacy;
		label: 'Sentry Error Tracking';
		noOrdering;
		with: [ (aBuilder setting: #enabled)
				target: self;
				label: 'Enable Reporting';
				description: 'Enable submission to Sentry server.'.
			(aBuilder setting: #autoSubmit)
				target: self;
				label: 'Automatic Submission';
				description: 'Reports will be sent automatically without user confirmation.'.
			(aBuilder setting: #enableContextData)
				target: self;
				label: 'Send Context Data';
				description:
					'Enabling this will send context data (parameter values, etc.). Although helpful for debugging, such data can contain sensitive information.'.
			(aBuilder setting: #showNotification)
				target: self;
				label: 'Show Notifications';
				description: 'An unobtrusive notification will appear when an error has been sent.'.
			(aBuilder group: #sentrySettings)
				label: 'Sentry Settings';
				noOrdering;
				with: [ (aBuilder setting: #dsn)
						target: self;
						label: 'DSN';
						description: 'Default DSN settings';
						type: #String ] ]
]

{ #category : #settings }
Sentry class >> showNotification [
	^ showNotification ifNil: [ showNotification := true ]
]

{ #category : #settings }
Sentry class >> showNotification: aBoolean [
	^ showNotification := aBoolean
]
