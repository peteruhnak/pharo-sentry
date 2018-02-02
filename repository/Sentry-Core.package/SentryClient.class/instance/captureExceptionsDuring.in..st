capturing
captureExceptionsDuring: aBlock in: anEventBlock
	aBlock
		on: Exception
		do: [ :err | self captureException: err in: anEventBlock ]