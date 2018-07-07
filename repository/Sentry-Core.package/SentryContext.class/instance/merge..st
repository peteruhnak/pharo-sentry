merging
merge: aCollectionOrContext
	aCollectionOrContext asDictionary
		keysAndValuesDo: [ :key :value | 
			value isString
				ifTrue: [ self perform: key asSymbol asMutator with: value ]
				ifFalse: [ self perform: key asSymbol asMutator with: (self perform: key asSymbol) , value ] ]