Extension { #name : #WrapperSignal }

{ #category : #'*Sentry-Beacon' }
WrapperSignal >> sentrySerializeOn: aSerializer logger: aLogger [
	^ aSerializer serializeWrapperSignal: self logger: aLogger
]
