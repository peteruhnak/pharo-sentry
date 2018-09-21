Class {
	#name : #SentryHttpTransport,
	#superclass : #SentryTransport,
	#instVars : [
		'enableNotifications'
	],
	#category : 'Sentry-Core-Model'
}

{ #category : #accessing }
SentryHttpTransport >> authHeaderFor: aDsn [
	^ {'Sentry sentry_version=7'.
	'sentry_timestamp=' , DateAndTime now asUnixTime asString.
	'sentry_key=' , aDsn username.
	'sentry_secret=' , aDsn password.
	'sentry_client=' , Sentry sdkName , '/' , Sentry sdkVersion} joinUsing: ','
]

{ #category : #initialization }
SentryHttpTransport >> initialize [
	super initialize.
	enableNotifications := true
]

{ #category : #sending }
SentryHttpTransport >> postClient: aZnClient [
	[ [ aZnClient post.
	self processResponse: aZnClient response ]
		on: NetworkError
		do: [ :ex | self processException: ex ] ] fork
]

{ #category : #sending }
SentryHttpTransport >> processException: anException [
	Sentry showNotification
		ifFalse: [ ^ self ].
	(anException isKindOf: ConnectionTimedOut)
		ifTrue: [ ^ self inform: 'Connecting to logging server timed out.' ].
	self inform: 'Logging the error to remote server failed (no connection?).'
]

{ #category : #sending }
SentryHttpTransport >> processResponse: aResponse [
	Sentry showNotification & enableNotifications
		ifFalse: [ ^ self ].
	aResponse isSuccess
		ifTrue: [ ^ self inform: 'Error report sent.' ].
	self
		inform:
			'Failed to send error report.' , String cr , '[' , aResponse code asString , '] '
				, (aResponse headers at: 'X-Sentry-Error' ifAbsent: [ '' ])
]

{ #category : #accessing }
SentryHttpTransport >> reportUrlFor: aDsn [
	^ ZnUrl new
		scheme: aDsn scheme;
		host: aDsn host;
		port: aDsn port;
		segments:
			{'api'.
			aDsn path.
			'store'.
			''};
		yourself
]

{ #category : #sending }
SentryHttpTransport >> send: aDictionary to: aDsn [
	enableNotifications := aDictionary includesKey: 'exception'.
	self
		postClient:
			(ZnClient new
				beOneShot;
				headerAt: 'User-Agent' put: self userAgent;
				headerAt: 'X-Sentry-Auth' put: (self authHeaderFor: aDsn);
				accept: ZnMimeType applicationJson;
				url: (self reportUrlFor: aDsn);
				entity: (ZnEntity with: (STON toJsonString: aDictionary) type: ZnMimeType applicationJson);
				yourself)
]

{ #category : #accessing }
SentryHttpTransport >> userAgent [
	^ Sentry sdkName , '/' , Sentry sdkVersion
]
