# pharo-sentry
[![Build Status][travis-badge]][travis] [![Coverage Status][coveralls-badge]][coveralls]

Unofficial, experimental Pharo SDK for [sentry.io](https://docs.sentry.io/clientdev/).

Note that the API is subject to change.

## Installation

```smalltalk
Metacello new
	baseline: 'Sentry';
	repository: 'github://peteruhnak/pharo-sentry:v0.1.0/repository';
	load
```

## Configuration

First Sentry needs to be provided with a proper `DSN`. You can instantiate own `SentryClient`, however a default one is available, which is also used by Beacon and Debugger (see further).

```smalltalk
Sentry default dsn: 'https://username:password@sentry.example.com/3'.
"or"
client := SentryClient dsn: 'https://username:password@sentry.example.com/3'.
```

To test that everything works, you can use `#sendSampleEvent` to send a sample event to your server with all the default values.

```smalltalk
client sendSampleEvent. "84f18c0e-db20-0d00-a6b2-68f8005e2515"
```

![](figures/sentry-sample.png)

### Advanced Configuration

It is possible to globally configure [in_app](https://docs.sentry.io/clientdev/interfaces/stacktrace/) attribute by providing a regex to be used for matching package names.

```smalltalk
Sentry default appPackages: 'MyPackage|Other-*'.
```

To globally configure an event, `beforeSend:` can be used. The provided block will be called just before the actual transport of the event. Note that this will be changed in favor of configuration context.

```smalltalk
client beforeSend: [ :event | event tags: {'foo' -> 'bar'} asDictionary ]
```

## Usage

### Beacon

*pharo-sentry* is not meant to be used directly, but rather as an endpoint for an actual logging framework.

For [Beacon](https://github.com/pharo-project/pharo-beacon) there's a custom `SentryLogger` that serializes exception signals into their sentry equivalents, and string signals into sentry messages. The serializations are then dispatched via Sentry.

```smalltalk
SentryLogger start.
StringSignal emit: 'test'.
SentryLogger stop.

"or"

SentryLogger new runDuring: [
	[ 1/0 ] on: Exception do: [ :ex | ex emit ]
].
```

### Core

To use *pharo-sentry* directly you can dispatch messages both on a client instance and the `Sentry` class.

```smalltalk
client captureMessage: 'It is alive!'. "7c5bf17d-dc20-0d00-a6b5-eef6005e2515"

[ 1/0 ] on: Exception do: [ :ex | Sentry captureException: ex ].

"silently capture exceptions and send them to sentry"
Sentry captureExceptionsDuring: [ :ex |
	1/0
].
```

On success, all `capture*` messages return an instance of `UUID` corresponding to the dispatched event.

To configure attributes of an event, additional `in:` parameter can be used. This parameter takes a block, which will receive the `SentryEvent` object.

```smalltalk
Sentry captureException: ex in: [ :event |
	event level: 'info'.
	event tags: {'foo' -> 'bar'} asDictionary
].
```

### Debugger

When sentry is enabled, a new button *Report (Sentry)* will appear in the PreDebugWindow. Clicking the button will dispatch the exception to the sentry server.

![](figures/sentry-debugger.png)

## Settings

Additional configuration is available in System Settings, described there. Note that for Sentry to work, it must be both enabled, and have DSN specified.

![](figures/sentry-settings.png)




[travis-badge]: https://travis-ci.org/peteruhnak/pharo-sentry.svg?branch=master
[travis]: https://travis-ci.org/peteruhnak/pharo-sentry
[coveralls-badge]: https://coveralls.io/repos/github/peteruhnak/pharo-sentry/badge.svg?branch=master
[coveralls]: https://coveralls.io/github/peteruhnak/pharo-sentry?branch=master
