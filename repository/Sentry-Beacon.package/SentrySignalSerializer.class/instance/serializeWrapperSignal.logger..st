serializing
serializeWrapperSignal: aWrapperSignal logger: aLogger
	^ (self eventFor: aWrapperSignal)
		message: aWrapperSignal printOneLineString;
		yourself