accessing
reportUrlFor: aDsn
	^ ZnUrl new
		scheme: aDsn scheme;
		host: aDsn host;
		port: aDsn port;
		segments:
			{'api'.
			aDsn path.
			'store'.
			''};
		yourself