actions
requestProceed
	| message |
	message := String
		streamContents: [ :stream | 
			stream
				<< 'Do you want to submit a stack trace for the current exception?';
				cr.
			stream << 'Sending of context data (parameter values) is '.
			Sentry enableContextData
				ifTrue: [ stream << 'ENABLED' ]
				ifFalse: [ stream << 'DISABLED' ].
			stream << '.' ].
	^ UIManager default proceed: message title: 'Send Error Report'