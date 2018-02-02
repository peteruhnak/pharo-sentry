serializing
serializeBeaconSignal: aSignal logger: aLogger
	^ (self eventFor: aSignal)
		message: aSignal printOneLineString;
		yourself