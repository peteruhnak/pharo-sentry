actions
appliesToDebugger: aDebugger
	Sentry enabled & Sentry autoSubmit
		ifTrue: [ self sendReportFor: aDebugger ].
	^ Sentry enabled