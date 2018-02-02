accessing - convenience
method: aMethod
	self filenameFromMethod: aMethod.
	self function: aMethod selector.
	self module: aMethod methodClass package name asString