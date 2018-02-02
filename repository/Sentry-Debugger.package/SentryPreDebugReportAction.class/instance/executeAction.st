actions
executeAction
	self requestProceed
		ifTrue: [ self sendReportFor: debugger ]