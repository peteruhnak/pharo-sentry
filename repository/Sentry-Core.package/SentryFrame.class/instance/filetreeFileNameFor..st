accessing - derived
filetreeFileNameFor: aMethod
	^ String
		streamContents: [ :stream | 
			| methodClass |
			methodClass := aMethod methodClass.
			stream
				<< methodClass package name;
				<< '.package';
				<< '/'.
			stream
				<< methodClass theNonMetaClass name;
				<< '.class';
				<< '/'.
			methodClass isMeta
				ifTrue: [ stream << 'class' ]
				ifFalse: [ stream << 'instance' ].
			stream << '/'.
			stream
				<< (MCFileTreeStCypressWriter fileNameForSelector: aMethod selector);
				<< '.st' ]