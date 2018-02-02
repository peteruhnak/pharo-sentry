converting
asDictionary
	^ {'frames' -> (self frames collect: #asDictionary)} asDictionary
		, (self asDictionary: #() optional: #(frames_omitted))