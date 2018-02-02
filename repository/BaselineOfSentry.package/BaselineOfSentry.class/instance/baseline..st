baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Beacon'
				with: [ spec repository: 'github://pharo-project/pharo-beacon/repository' ].
			spec
				package: 'Sentry-Core';
				package: 'Sentry-Beacon' with: [ spec requires: #('Sentry-Core' 'Beacon') ];
				package: 'Sentry-Debugger' with: [ spec requires: #('Sentry-Core') ];
				package: 'Sentry-Tests' with: [ spec requires: #('Sentry-Core' 'Sentry-Beacon') ].
			spec group: 'Core' with: #('Sentry-Core').
			spec
				group: 'default'
				with: #('Sentry-Core' 'Sentry-Beacon' 'Sentry-Debugger' 'Sentry-Tests') ]