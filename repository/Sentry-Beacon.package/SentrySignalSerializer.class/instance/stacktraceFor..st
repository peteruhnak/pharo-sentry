capturing
stacktraceFor: aStack
	| frames |
	frames := aStack
		collect: [ :aNode | 
			| methodNode |
			methodNode := aNode methodNode.
			SentryFrame new
				method: methodNode;
				code: aNode source start: aNode sourceInterval first;
				inApp: (Sentry default isMethodInApp: methodNode) ].
	^ SentryStacktrace new frames: frames reversed asArray