"
I take a Sentry data object (Event or an Interface) and produce a Dictionary.
"
Class {
	#name : #SentryConverter,
	#superclass : #Object,
	#category : 'Sentry-Core-Utils'
}

{ #category : #converting }
SentryConverter >> asDictionary: anObject keys: keys [
	| dict |
	dict := Dictionary new.
	keys
		do: [ :each | 
			| value |
			value := self read: anObject using: each.
			self assert: [ value isNotNil ] description: each , ' is a mandatory argument.'.
			dict at: each put: value ].
	^ dict
]

{ #category : #converting }
SentryConverter >> asDictionary: anObject keys: keys optional: optionalKeys [
	| dict |
	dict := self asDictionary: anObject keys: keys.
	optionalKeys
		do: [ :each | 
			(self read: anObject using: each)
				ifNotNil: [ :value | 
					(value isCollection and: [ value isEmpty ])
						ifFalse: [ dict at: each put: value ] ] ].
	^ dict
]

{ #category : #converting }
SentryConverter >> read: anObject using: aKey [
	| selector value |
	selector := (((aKey splitOn: $_) collect: #capitalized) joinUsing: '') uncapitalized
		asSymbol.
	value := selector value: anObject.
	^ (value isKindOf: SentryInterface)
		ifTrue: [ value asDictionary ]
		ifFalse: [ value ]
]
