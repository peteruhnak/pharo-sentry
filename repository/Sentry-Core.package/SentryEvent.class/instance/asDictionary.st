accessing - special
asDictionary
	| dict |
	dict := self requiredPayload
		,
			(SentryConverter new
				asDictionary: self
				keys: #(logger platform sdk)
				optional: #(level culprit serverName release tags environment modules extra fingerprint)).
	dict
		at: 'tags'
		ifPresent: [ :t | 
			t isEmpty
				ifTrue: [ dict removeKey: 'tags' ] ].
	self message
		ifNotNil: [ :msg | 
			msg isString
				ifTrue: [ dict at: 'message' put: msg ]
				ifFalse: [ dict at: 'sentry.interfaces.Message' put: msg asDictionary ] ].
	self exception ifNotNil: [ :ex | dict at: 'exception' put: ex asDictionary ].
	^ dict