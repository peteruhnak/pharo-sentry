converting
asDictionary
	^ {'timestamp' -> (self isoTimestampFor: self timestamp)} asDictionary
		, (self asDictionary: #(category) optional: #(type message data level))