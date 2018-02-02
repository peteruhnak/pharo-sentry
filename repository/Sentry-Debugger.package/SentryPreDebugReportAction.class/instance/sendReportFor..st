actions
sendReportFor: aDebugger
	SentryLogger
		runDuring: [ (aDebugger session interruptedProcess suspendedContext stack
				detect: [ :context | context receiver isKindOf: Exception ]) receiver emit ].
	self label: 'Report (already reported)'