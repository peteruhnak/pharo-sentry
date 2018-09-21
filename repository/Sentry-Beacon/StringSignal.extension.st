Extension { #name : #StringSignal }

{ #category : #'*Sentry-Beacon' }
StringSignal >> sentrySerializeOn: aSerializer logger: aLogger [
	^ aSerializer serializeStringSignal: self logger: aLogger
]
