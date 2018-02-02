accessing - derived
tonelFileNameFor: aMethod
	^ String
		streamContents: [ :stream | 
			| methodClass |
			methodClass := aMethod methodClass.
			stream
				<< methodClass package name;
				<< '/'.
			stream
				<< methodClass theNonMetaClass name;
				<< '.class.st' ]