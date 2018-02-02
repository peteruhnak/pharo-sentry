tests
testIsMethodInApp
	| method |
	method := SentryClientTest >> #testIsMethodInApp.
	client appPackages: 'Sentry'.
	self assert: (client isMethodInApp: method).
	client appPackages: {'Sentry' asPackage}.
	self assert: (client isMethodInApp: method).
	client appPackages: 'Kernel'.
	self deny: (client isMethodInApp: method)