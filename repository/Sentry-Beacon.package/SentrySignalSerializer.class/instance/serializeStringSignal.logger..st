serializing
serializeStringSignal: aStringSignal logger: aLogger
	^ (self eventFor: aStringSignal)
		message: aStringSignal message;
		yourself