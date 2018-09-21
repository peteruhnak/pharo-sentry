"
I am a button in the PreDebugger with which a user can submit an exception report.
"
Class {
	#name : #SentryPreDebugReportAction,
	#superclass : #PreDebugAction,
	#category : 'Sentry-Debugger'
}

{ #category : #registration }
SentryPreDebugReportAction class >> actionType [
	<preDebuggingAction>
]

{ #category : #actions }
SentryPreDebugReportAction >> appliesToDebugger: aDebugger [
	Sentry enabled & Sentry autoSubmit
		ifTrue: [ self sendReportFor: aDebugger ].
	^ Sentry enabled
]

{ #category : #actions }
SentryPreDebugReportAction >> defaultLabel [
	^ 'Report (Sentry)'
]

{ #category : #actions }
SentryPreDebugReportAction >> defaultOrder [
	^ 30
]

{ #category : #actions }
SentryPreDebugReportAction >> executeAction [
	self requestProceed
		ifTrue: [ self sendReportFor: debugger ]
]

{ #category : #actions }
SentryPreDebugReportAction >> forDebugger: aDebugger [
	super forDebugger: aDebugger
]

{ #category : #actions }
SentryPreDebugReportAction >> id [
	^ #sentryPreDebugReportAction
]

{ #category : #actions }
SentryPreDebugReportAction >> requestProceed [
	| message |
	message := String
		streamContents: [ :stream | 
			stream
				<< 'Do you want to submit a stack trace for the current exception?';
				cr.
			stream << 'Sending of context data (parameter values) is '.
			Sentry enableContextData
				ifTrue: [ stream << 'ENABLED' ]
				ifFalse: [ stream << 'DISABLED' ].
			stream << '.' ].
	^ UIManager default proceed: message title: 'Send Error Report'
]

{ #category : #actions }
SentryPreDebugReportAction >> sendReportFor: aDebugger [
	SentryLogger
		runDuring: [ (aDebugger session interruptedProcess suspendedContext stack
				detect: [ :context | context receiver isKindOf: Exception ]) receiver emit ].
	self label: 'Report (already reported)'
]
