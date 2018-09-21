Class {
	#name : #SentryFrameTest,
	#superclass : #TestCase,
	#category : 'Sentry-Tests'
}

{ #category : #tests }
SentryFrameTest >> testAsDictionary [
	self
		assert:
			(SentryFrame new
				filename: 'fn';
				function: 'fun';
				module: 'mod';
				inApp: true;
				asDictionary)
		equals:
			{'filename' -> 'fn'.
			'function' -> 'fun'.
			'module' -> 'mod'.
			'in_app' -> true} asDictionary
]

{ #category : #tests }
SentryFrameTest >> testAsDictionaryFull [
	self
		assert:
			(SentryFrame new
				filename: 'fn';
				function: 'fun';
				module: 'mod';
				lineno: 20;
				absPath: 'abs';
				contextLine: 'line ctx';
				preContext: #(line1 line2);
				postContext: #(line3 line4);
				inApp: true;
				vars: {#a -> #b} asDictionary;
				asDictionary)
		equals:
			{'filename' -> 'fn'.
			'function' -> 'fun'.
			'module' -> 'mod'.
			'lineno' -> 20.
			'abs_path' -> 'abs'.
			'context_line' -> 'line ctx'.
			'pre_context' -> #(line1 line2).
			'post_context' -> #(line3 line4).
			'vars' -> {#a -> #b} asDictionary.
			'in_app' -> true} asDictionary
]

{ #category : #tests }
SentryFrameTest >> testFiletreeFileName [
	self
		assert: (SentryFrame new filetreeFileNameFor: SentryClient >> #dsn:)
		equals: 'Sentry-Core.package/SentryClient.class/instance/dsn..st'.
	self
		assert: (SentryFrame new filetreeFileNameFor: SentryClient class >> #dsn:)
		equals: 'Sentry-Core.package/SentryClient.class/class/dsn..st'
]

{ #category : #tests }
SentryFrameTest >> testTonelFileName [
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient >> #dsn:)
		equals: 'Sentry-Core/SentryClient.class.st'.
	self
		assert: (SentryFrame new tonelFileNameFor: SentryClient class >> #dsn:)
		equals: 'Sentry-Core/SentryClient.class.st'
]
