examples
sendSampleMessage
	self captureMessage: 'Sample Message' in: [ :event | event level: 'sample' ]