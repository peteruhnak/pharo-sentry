======
Beacon
======

In a typical scenario you are not meant to use *pharo-sentry* directly.
Instead, it should be used as an end-point for a logging framework, such as `Beacon <https://github.com/pharo-project/pharo-beacon>`_.

SentryLogger
============

*pharo-sentry* includes a Beacon logger called ``SentryLogger`` that serializes and dispatches exceptions via sentry::

	SentryLogger new runDuring: [
		[ 1/0 ] on: Exception do: [ :ex | ex emit ]
	].

Likewise string-based signals are serialized into sentry messages::

	SentryLogger start.
	StringSignal emit: 'test'.
	SentryLogger stop.

Beacon Properties
=================

The serializer takes into account Beacon's timestamp, reporting level, and custom properties.
Custom properties are converted to Sentry tags::

	SentryLogger runDuring: [
		StringSignal new
			message: 'The Sun didn''t rise';
			level: LogLevel error;
			in: [ :signal | signal properties at: 'foo' put: 'bar' ];
			emit
	]

.. note::

	Events created using SentryLogger are marked as *beacon logger*, instead of the standard *pharo-sentry*.
