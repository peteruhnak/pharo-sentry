examples
sendSampleException
	^ [ self error: 'Sample Exception' ]
		on: Exception
		do: [ :ex | self captureException: ex in: [ :event | event level: 'sample' ] ]