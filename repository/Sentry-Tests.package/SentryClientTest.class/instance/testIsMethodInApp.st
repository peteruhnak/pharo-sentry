tests
testIsMethodInApp
	| method |
	method := SentryClientTest >> #testIsMethodInApp.
	client appPackages: 'Sentry-Tests'.
	self assert: (client isMethodInApp: method).
	client appPackages: {'Sentry-Tests' asPackage}.
	self assert: (client isMethodInApp: method).
	client appPackages: 'Kernel'.
	self deny: (client isMethodInApp: method)