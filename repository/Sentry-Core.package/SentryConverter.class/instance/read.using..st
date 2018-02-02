converting
read: anObject using: aKey
	| selector value |
	selector := (((aKey splitOn: $_) collect: #capitalized) joinUsing: '') uncapitalized
		asSymbol.
	value := selector value: anObject.
	^ (value isKindOf: SentryInterface)
		ifTrue: [ value asDictionary ]
		ifFalse: [ value ]