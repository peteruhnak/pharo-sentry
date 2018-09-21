Extension { #name : #BeaconSignal }

{ #category : #'*Sentry-Beacon' }
BeaconSignal >> sentrySerializeOn: aSerializer logger: aLogger [
	^ aSerializer serializeBeaconSignal: self logger: aLogger
]
