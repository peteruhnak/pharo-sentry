Class {
	#name : #SentryClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client'
	],
	#category : 'Sentry-Tests'
}

{ #category : #accessing }
SentryClientTest >> sampleDsn [
	^ 'https://a:b@c/1'
]

{ #category : #running }
SentryClientTest >> setUp [
	super setUp.
	client := SentryClient new dsn: 'https://username:secret@localhost/1'.
	client transport: SentryDummyTransport new
]

{ #category : #'tests - accessing' }
SentryClientTest >> testBeforeSend [
	| event |
	client transport: SentryDummyTransport new.
	client beforeSend: [ :ev | ev logger: 'dummy' ].
	event := SentryEvent new.
	client send: event.
	self assert: event logger equals: 'dummy'
]

{ #category : #'tests - breadcrumbs' }
SentryClientTest >> testBreadcrumbsAreCleanedUp [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		recordBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	self deny: client breadcrumbs isEmpty.
	client sendSampleMessage.
	self assert: client breadcrumbs isEmpty
]

{ #category : #'tests - breadcrumbs' }
SentryClientTest >> testBreadcrumbsAreSent [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		recordBreadcrumbIn: [ :crumb | 
			crumb
				category: 'test';
				message: 'hello' ].
	client sendSampleMessage.
	self assert: ((data at: 'breadcrumbs') first at: 'message') equals: 'hello'
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureException [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | client captureException: ex ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureExceptionIn [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | client captureException: ex in: [ :event | event logger: 'dummy' ] ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty.
	self assert: (data at: 'logger') equals: 'dummy'
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureExceptionsDuring [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureExceptionsDuring: [ Error signal: 'msg' ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureExceptionsDuringIn [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client
		captureExceptionsDuring: [ Error signal: 'msg' ]
		in: [ :event | event logger: 'dummy' ].
	self assert: (data at: 'message') equals: 'Error: msg'.
	self assert: (data at: 'exception') isNotEmpty.
	self assert: (data at: 'logger') equals: 'dummy'
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureMessage [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello'.
	self assert: (data at: 'message') equals: 'hello'
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureMessageIn [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' in: [:event | event logger: 'dummy' ].
	self assert: (data at: 'message') equals: 'hello'.
	self assert: (data at: 'logger') equals: 'dummy'.
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureMessageParams [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' params: #(a b).
	self
		assert: (data at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello'.
			'params' -> #(a b)} asDictionary
]

{ #category : #'tests - capturing' }
SentryClientTest >> testCaptureMessageParamsIn [
	| data |
	client transport onSend: [ :dict :dsn | data := dict ].
	client captureMessage: 'hello' params: #(a b) in: [ :event | event logger: 'dummy' ].
	self
		assert: (data at: 'sentry.interfaces.Message')
		equals:
			{'message' -> 'hello'.
			'params' -> #(a b)} asDictionary.
	self assert: (data at: 'logger') equals: 'dummy'
]

{ #category : #'tests - instance creation' }
SentryClientTest >> testDsnCreate [
	client := SentryClient dsn: self sampleDsn.
	self assert: client dsn equals: self sampleDsn asZnUrl
]

{ #category : #'tests - accessing' }
SentryClientTest >> testDsnDisabled [
	client dsn: ''.
	self deny: client isEnabled.
	client dsn: 'https://a:b@c/1'.
	self assert: client isEnabled
]

{ #category : #'tests - accessing' }
SentryClientTest >> testDsnDisablesSending [
	| sent |
	sent := false.
	client transport: (SentryDummyTransport new onSend: [ :dict :dsn | sent := true ]).
	client dsn: ''.
	client send: (SentryEvent new).
	self deny: sent.
]

{ #category : #'tests - testing' }
SentryClientTest >> testIsMethodInApp [
	| method |
	method := SentryClientTest >> #testIsMethodInApp.
	client appPackages: 'Sentry-Tests'.
	self assert: (client isMethodInApp: method).
	client appPackages: {'Sentry-Tests' asPackage}.
	self assert: (client isMethodInApp: method).
	client appPackages: 'Kernel'.
	self deny: (client isMethodInApp: method)
]

{ #category : #'tests - extraction' }
SentryClientTest >> testLastFrameStacktraceForException [
	| data stacktrace frame |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | stacktrace := client stacktraceFor: ex ].
	frame := stacktrace frames last.
	self
		assert: frame filename
		equals: 'Sentry-Tests.package/SentryClientTest.class/instance/testLastFrameStacktraceForException.st'.
	self assert: frame function equals: #testLastFrameStacktraceForException.
	self assert: frame module equals: 'Sentry-Tests'.
	self assert: frame lineno equals: 4.
	self assert: frame contextLine equals: '	[ Error signal: ''msg'' ]'
]

{ #category : #'tests - extraction' }
SentryClientTest >> testLastFrameVarsStacktraceForException [
	| data stacktrace frame |
	client transport onSend: [ :dict :dsn | data := dict ].
	[ Error signal: 'msg' ]
		on: Error
		do: [ :ex | stacktrace := client stacktraceFor: ex ].
	frame := stacktrace frames last.
	self
		assert: frame vars
		equals:
			{'_context'
				->
					'[ Error signal: ''msg'' ] in SentryClientTest>>testLastFrameVarsStacktraceForException'.
			'_receiver' -> 'SentryClientTest>>#testLastFrameVarsStacktraceForException'}
				asDictionary
]

{ #category : #'tests - breadcrumbs' }
SentryClientTest >> testRecordBreadcrumbIn [
	client recordBreadcrumbIn: [ :crumb | crumb message: 'hello' ].
	self assert: (client breadcrumbs collect: #message) asArray equals: #('hello')
]

{ #category : #'tests - validation' }
SentryClientTest >> testValidateDsn [
	self
		shouldnt: [ client validateDsn: 'https://public:secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'public:secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'https://secret@sentry.example.com/1' asZnUrl ]
		raise: AssertionFailure.
	self
		should: [ client validateDsn: 'https://secret@sentry.example.com/' asZnUrl ]
		raise: AssertionFailure
]
