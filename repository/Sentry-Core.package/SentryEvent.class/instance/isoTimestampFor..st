formatting
isoTimestampFor: aDateTime
	| utc |
	utc := aDateTime asUTC.
	^ String
		streamContents: [ :aStream | 
			utc printYMDOn: aStream withLeadingSpace: false.
			aStream nextPut: $T.
			utc printHMSOn: aStream ]