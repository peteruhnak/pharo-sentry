converting
asDictionary: anObject keys: keys optional: optionalKeys
	| dict |
	dict := self asDictionary: anObject keys: keys.
	optionalKeys
		do:
			[ :each | (self read: anObject using: each) ifNotNil: [ :value | dict at: each put: value ] ].
	^ dict