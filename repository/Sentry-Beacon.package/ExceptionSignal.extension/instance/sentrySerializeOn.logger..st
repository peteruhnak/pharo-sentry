*Sentry-Beacon
sentrySerializeOn: aSerializer logger: aLogger
	^ aSerializer serializeExceptionSignal: self logger: aLogger