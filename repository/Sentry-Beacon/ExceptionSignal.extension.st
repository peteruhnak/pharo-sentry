Extension { #name : #ExceptionSignal }

{ #category : #'*Sentry-Beacon' }
ExceptionSignal >> sentrySerializeOn: aSerializer logger: aLogger [
	^ aSerializer serializeExceptionSignal: self logger: aLogger
]
