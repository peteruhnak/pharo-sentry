sending
postClient: aZnClient
	[ [ aZnClient post.
	self processResponse: aZnClient response ]
		on: NetworkError
		do: [ :ex | self processException: ex ] ] fork