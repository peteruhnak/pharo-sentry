converting
asDictionary: anObject keys: keys optional: optionalKeys
	| dict |
	dict := self asDictionary: anObject keys: keys.
	optionalKeys
		do: [ :each | 
			(self read: anObject using: each)
				ifNotNil: [ :value | 
					(value isCollection and: [ value isEmpty ])
						ifFalse: [ dict at: each put: value ] ] ].
	^ dict