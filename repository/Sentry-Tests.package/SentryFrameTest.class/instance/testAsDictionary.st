tests
testAsDictionary
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