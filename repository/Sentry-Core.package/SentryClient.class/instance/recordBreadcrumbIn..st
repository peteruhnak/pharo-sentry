capturing
recordBreadcrumbIn: aOneArgBlock
	| crumb |
	crumb := SentryBreadcrumb new.
	aOneArgBlock value: crumb.
	breadcrumbs add: crumb