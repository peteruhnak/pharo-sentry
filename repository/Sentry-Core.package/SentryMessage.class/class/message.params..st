instance creation
message: aString params: aCollection
	^ self new
		message: aString;
		params: aCollection;
		yourself