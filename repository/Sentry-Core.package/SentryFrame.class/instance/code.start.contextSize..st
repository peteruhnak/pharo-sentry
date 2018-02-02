accessing - convenience
code: aSource start: aSelectionStart contextSize: aContextSize
	| lines line |
	lines := aSource lines.
	line := aSource lineNumberCorrespondingToIndex: aSelectionStart.
	self
		lineno: line;
		contextLine: (lines at: line);
		preContext: (lines copyFrom: (1 max: line - aContextSize) to: line - 1);
		postContext: (lines copyFrom: line + 1 to: (lines size min: line + aContextSize))