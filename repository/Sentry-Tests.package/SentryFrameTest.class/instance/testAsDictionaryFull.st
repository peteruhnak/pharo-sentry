tests
testAsDictionaryFull
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