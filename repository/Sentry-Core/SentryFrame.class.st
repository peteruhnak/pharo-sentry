Class {
	#name : #SentryFrame,
	#superclass : #SentryInterface,
	#instVars : [
		'filename',
		'function',
		'module',
		'lineno',
		'colno',
		'absPath',
		'contextLine',
		'preContext',
		'postContext',
		'inApp',
		'vars'
	],
	#category : #'Sentry-Core-Model'
}

{ #category : #accessing }
SentryFrame >> absPath [
	^ absPath
]

{ #category : #accessing }
SentryFrame >> absPath: anObject [
	absPath := anObject
]

{ #category : #converting }
SentryFrame >> asDictionary [
	^ self
		asDictionary: #(filename function module)
		optional: #(lineno colno abs_path context_line pre_context post_context in_app vars)
]

{ #category : #'accessing - convenience' }
SentryFrame >> code: aSource start: aSelectionStart [
	^ self code: aSource start: aSelectionStart contextSize: 5
]

{ #category : #'accessing - convenience' }
SentryFrame >> code: aSource start: aSelectionStart contextSize: aContextSize [
	| lines line |
	lines := aSource lines.
	line := aSource lineNumberCorrespondingToIndex: aSelectionStart.
	self
		lineno: line;
		contextLine: (lines at: line);
		preContext: (lines copyFrom: (1 max: line - aContextSize) to: line - 1);
		postContext: (lines copyFrom: line + 1 to: (lines size min: line + aContextSize))
]

{ #category : #accessing }
SentryFrame >> colno [
	^ colno
]

{ #category : #accessing }
SentryFrame >> colno: anObject [
	colno := anObject
]

{ #category : #accessing }
SentryFrame >> contextLine [
	^ contextLine
]

{ #category : #accessing }
SentryFrame >> contextLine: anObject [
	contextLine := anObject
]

{ #category : #'accessing - derived' }
SentryFrame >> fileNameFor: aMethod [
	^ self filetreeFileNameFor: aMethod
]

{ #category : #accessing }
SentryFrame >> filename [
	^ filename
]

{ #category : #accessing }
SentryFrame >> filename: anObject [
	filename := anObject
]

{ #category : #'accessing - convenience' }
SentryFrame >> filenameFromMethod: aMethod [
	self filename: (self fileNameFor: aMethod)
]

{ #category : #'accessing - derived' }
SentryFrame >> filetreeFileNameFor: aMethod [

	^ String streamContents: [ :stream | 
		  | methodClass |
		  methodClass := aMethod methodClass.
		  stream
			  << methodClass package name;
			  << '.package';
			  << '/'.
		  stream
			  << methodClass instanceSide name;
			  << '.class';
			  << '/'.
		  methodClass isMeta
			  ifTrue: [ stream << 'class' ]
			  ifFalse: [ stream << 'instance' ].
		  stream << '/'.
		  stream
			  <<
				  (MCFileTreeStCypressWriter fileNameForSelector: aMethod selector);
			  << '.st' ]
]

{ #category : #accessing }
SentryFrame >> function [
	^ function
]

{ #category : #accessing }
SentryFrame >> function: anObject [
	function := anObject
]

{ #category : #accessing }
SentryFrame >> inApp [
	^ inApp
]

{ #category : #accessing }
SentryFrame >> inApp: anObject [
	inApp := anObject
]

{ #category : #accessing }
SentryFrame >> lineno [
	^ lineno
]

{ #category : #accessing }
SentryFrame >> lineno: anObject [
	lineno := anObject
]

{ #category : #'accessing - convenience' }
SentryFrame >> method: aMethod [
	self filenameFromMethod: aMethod.
	self function: aMethod selector.
	self module: aMethod methodClass package name asString
]

{ #category : #accessing }
SentryFrame >> module [
	^ module
]

{ #category : #accessing }
SentryFrame >> module: anObject [
	module := anObject
]

{ #category : #accessing }
SentryFrame >> postContext [
	^ postContext
]

{ #category : #accessing }
SentryFrame >> postContext: anObject [
	postContext := anObject
]

{ #category : #accessing }
SentryFrame >> preContext [
	^ preContext
]

{ #category : #accessing }
SentryFrame >> preContext: anObject [
	preContext := anObject
]

{ #category : #'accessing - derived' }
SentryFrame >> tonelFileNameFor: aMethod [
	^ String
		streamContents: [ :stream | 
			| methodClass |
			methodClass := aMethod methodClass.
			stream
				<< methodClass package name;
				<< '/'.
			stream
				<< methodClass theNonMetaClass name;
				<< '.class.st' ]
]

{ #category : #accessing }
SentryFrame >> vars [
	^ vars
]

{ #category : #accessing }
SentryFrame >> vars: anObject [
	vars := anObject
]
