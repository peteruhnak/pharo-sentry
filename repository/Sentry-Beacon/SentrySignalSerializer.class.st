"
I turn a BeaconSignal into its Sentry Event equivalent.
"
Class {
	#name : #SentrySignalSerializer,
	#superclass : #SignalSerializer,
	#category : 'Sentry-Beacon'
}

{ #category : #serializing }
SentrySignalSerializer >> eventFor: aSignal [
	^ SentryEvent new
		timestamp: aSignal timestamp;
		logger: 'beacon';
		level: aSignal level shortName;
		tags:
			(aSignal properties
				ifEmpty: [ nil ]
				ifNotEmpty: [ :dict | 
					dict copy
						removeKey: 'level' ifAbsent: [  ];
						yourself ]);
		yourself
]

{ #category : #serializing }
SentrySignalSerializer >> serializeBeaconSignal: aSignal logger: aLogger [
	^ (self eventFor: aSignal)
		message: aSignal printOneLineString;
		yourself
]

{ #category : #serializing }
SentrySignalSerializer >> serializeExceptionSignal: anExceptionSignal logger: aLogger [
	| event exception |
	exception := anExceptionSignal exception.
	event := self eventFor: anExceptionSignal.
	event message: exception description.
	event
		exception:
			(SentryException new
				values:
					{SentryExceptionValue new
						type: exception class name;
						value: exception messageText;
						module: exception class package name;
						stacktrace: (self stacktraceFor: anExceptionSignal stack exception: anExceptionSignal exception)}).
	^ event
]

{ #category : #serializing }
SentrySignalSerializer >> serializeSignal: aSignal logger: aLogger [
	^ aSignal sentrySerializeOn: self logger: aLogger
]

{ #category : #serializing }
SentrySignalSerializer >> serializeStringSignal: aStringSignal logger: aLogger [
	^ (self eventFor: aStringSignal)
		message: aStringSignal message;
		yourself
]

{ #category : #serializing }
SentrySignalSerializer >> serializeWrapperSignal: aWrapperSignal logger: aLogger [
	^ (self eventFor: aWrapperSignal)
		message: aWrapperSignal printOneLineString;
		yourself
]

{ #category : #capturing }
SentrySignalSerializer >> stacktraceFor: aStack exception: anException [
	^ Sentry default stacktraceFor: anException
]
