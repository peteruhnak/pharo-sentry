merging
merge: aCollectionOrContext
	aCollectionOrContext asDictionary
		keysAndValuesDo:
			[ :key :value | self perform: key asSymbol asMutator with: (self perform: key asSymbol) , value ]