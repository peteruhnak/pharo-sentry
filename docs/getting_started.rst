===============
Getting Started
===============

In this document you can learn the basic usage of Pharo Sentry. Please note that not all features of Sentry are supported yet.

Installation
============

::

	Metacello new
		baseline: 'Sentry';
		repository: 'github://peteruhnak/pharo-sentry:v0.2.0/repository';
		load

Basic Usage
===========

Capturing an Exception
----------------------

Exceptions are automatically serialized and dispatched::

	client := SentryClient dsn: 'https://<key>:<secret>@sentry.io/<project>'.

	[ 1 / 0 ] on: ZeroDivide do: [ :ex |
		client captureException: ex
	]

Sending a Message
-----------------

Messages contain arbitrary content that can help you debug your application or collect additional information::

	client captureMessage: 'The sun didn''t rise'

Sending Sample Events
---------------------

To verify that your everything is configured correctly, you can send sample exceptions and events.
This can be done either by setting the ``level`` of the event to ``sample``. Or you can use ready-to-use events::

	client sendSampleException.

	client sendSampleMessage.

.. figure:: figures/sentry-sample.png

	Sample exception in the sentry.io UI

Providing Context
=================

Usually you want to attach additional information to all events.
This can be achieved at the level of:

* Client, which will be applied to all future events:

::

	client context merge: { 'tags' -> { 'foo' -> 'bar' } asDictionary }

.. note::

	The argument provided to the ``context`` is automatically converted to ``Dictionary``.
	You still need to convert internal dictionaries though.

* Event, which will be applied only to a single event only:

::

	client captureMessage: 'The sun didn''t rise' in: [ :event |
		event tags: { 'foo' -> 'bar' } asDictionary
	]
