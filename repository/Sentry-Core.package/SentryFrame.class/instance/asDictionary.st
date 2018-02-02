converting
asDictionary
	^ self
		asDictionary: #(filename function module)
		optional: #(lineno colno abs_path context_line pre_context post_context in_app vars)