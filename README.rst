============
pharo-sentry
============

|travis| |coveralls|

*pharo-sentry* is an unofficial `Pharo <https://pharo.org/>`_ SDK for `Sentry <https://sentry.io/welcome/>`_ error tracking platform.

.. warning::

  This SDK is still under development and not all Sentry's API is supported yet.

.. warning::

  The API of this library is still subject to change.

For more in-depth documentation see https://peteruhnak.github.io/pharo-sentry/

Installation
============

.. code-block:: smalltalk

	Metacello new
		baseline: 'Sentry';
		repository: 'github://peteruhnak/pharo-sentry:v0.2.0/repository';
		load

Basic Usage
===========

Capturing an Exception
----------------------

Exceptions are automatically serialized and dispatched:

.. code-block:: smalltalk

	client := SentryClient dsn: 'https://<key>:<secret>@sentry.io/<project>'.

	[ 1 / 0 ] on: ZeroDivide do: [ :ex |
		client captureException: ex
	]

Sending a Message
-----------------

Messages contain arbitrary content that can help you debug your application or collect additional information:

.. code-block:: smalltalk

	client captureMessage: 'The sun didn''t rise'

Sending Sample Events
---------------------

To verify that your everything is configured correctly, you can send sample exceptions and events.
This can be done either by setting the ``level`` of the event to ``sample``. Or you can use ready-to-use events:

.. code-block:: smalltalk

	client sendSampleException.

	client sendSampleMessage.

.. figure:: figures/sentry-sample.png

	Sample exception in the sentry.io UI

Using Beacon
============

*pharo-sentry* includes a Beacon logger called ``SentryLogger`` that serializes and dispatches exceptions via sentry:

.. code-block:: smalltalk

	SentryLogger new runDuring: [
		[ 1/0 ] on: Exception do: [ :ex | ex emit ]
	].

Likewise string-based signals are serialized into sentry messages:

.. code-block:: smalltalk

	SentryLogger start.
	StringSignal emit: 'test'.
	SentryLogger stop.

.. |travis| image:: https://travis-ci.org/peteruhnak/pharo-sentry.svg?branch=master
    :target: https://travis-ci.org/peteruhnak/pharo-sentry
.. |coveralls| image:: https://coveralls.io/repos/github/peteruhnak/pharo-sentry/badge.svg?branch=master
    :target: https://coveralls.io/github/peteruhnak/pharo-sentry?branch=master
