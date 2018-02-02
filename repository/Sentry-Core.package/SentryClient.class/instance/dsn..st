accessing
dsn: aDsn
	| dsnUrl |
	dsnUrl := aDsn asZnUrl.
	self validateDsn: dsnUrl.
	dsn := dsnUrl