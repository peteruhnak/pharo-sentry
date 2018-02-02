sending
send: aDictionary to: aDsn
	self
		postClient:
			(ZnClient new
				beOneShot;
				headerAt: 'User-Agent' put: self userAgent;
				headerAt: 'X-Sentry-Auth' put: (self authHeaderFor: aDsn);
				accept: ZnMimeType applicationJson;
				url: (self reportUrlFor: aDsn);
				entity: (ZnEntity with: (STON toJsonString: aDictionary) type: ZnMimeType applicationJson);
				yourself)