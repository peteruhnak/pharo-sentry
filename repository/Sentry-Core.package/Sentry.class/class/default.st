accessing
default
	"
	default := nil
	"
	^ default ifNil: [ default := SentryClient new ]