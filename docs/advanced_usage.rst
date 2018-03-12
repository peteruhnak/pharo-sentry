==============
Advanced Usage
==============

Capturing
=========

Automatic Exception Capture
---------------------------

Any exceptions that occur in the block will be automatically handled and dispatched::

	client captureExceptionsDuring: [
		1/0
	].

Parametrized Messages
---------------------

Messages can be expressed as templates with parameters provided separately. The formatting will be performed on the sentry server::

	client captureMessage: 'Length of "%s" is %d.' params: #('hello' 5)

Breadcrumbs
===========

`Breadcrumbs <https://docs.sentry.io/clientdev/interfaces/breadcrumbs/>`_ are a trail of events that are buffered until a problem occurs::

	client recordBreadcrumbIn: [ :crumb |
		crumb category: 'trace.division'.
		crumb level: 'debug'.
		crumb data: { 'numerator' -> 1 } asDictionary.
		crumb message: 'numerator is 1'
	].

	client recordBreadcrumbIn: [ :crumb |
		crumb category: 'trace.division'.
		crumb level: 'debug'.
		crumb data: { 'denominator' -> 0 } asDictionary.
		crumb message: 'denominator is 0'
	].

	client captureExceptionsDuring: [ 1 / 0 ].

.. figure:: figures/sentry-breadcrumbs.png

	Trail of breadcrumbs in the UI

Once a message or expection is captured, all previous breadcrumbs are sent together with the event, and the buffer is cleared.
If needed, breadcrumbs can be cleared manually::

	client resetBreadcrumbs





Configuration
=============

Event Configuration
-------------------

All *capture* messages have a variant allowing further configuration of the event::

	client captureMessage: 'Foo!' in: [ :event |
		event tags: { 'foo' -> 'bar' } asDictionary.
		event level: 'warning'.
		event extra: { 'uuid' -> UUID new asString } asDictionary.
	].

The argument in the block is an instance of ``SentryEvent``.

Last-minute Configuration
-------------------------

To globally configure an event, ``beforeSend:`` can be used.
The provided block will be called just before the actual transport of the event::

	client beforeSend: [ :event | event tags: {'foo' -> 'bar'} asDictionary ]

.. note:: ``beforeSend:`` will be replaced in favor of direct context configuration.

Context Configuration
---------------------

Context common to all events be configured using ``merge:``::

	client context merge: { 'user' -> {
		'id' -> UUID new asString.
		'email' -> 'me@example.com' } asDictionary }.

To clear context, use ``clear``::

	client clear


Pharo-Specific
==============

in_app Configuration
--------------------

The `in_app <https://docs.sentry.io/clientdev/interfaces/stacktrace/>`_ attribute is determined based on the package of the incriminating code.

To specify your app packages, provide either a regex or a list of packages::

	"Packages as regex"
	client appPackages: 'Sentry-*|Beacon-Core'.

	"Collection of packages"
	client appPackages: { 'Sentry-Core' asPackage. 'Beacon-Core' asPackage }


Retrieving Last Event
---------------------

The last event that was sent can still be accessed on the client::

	UIManager default alert: 'Error reported as ', client lastEvent eventIdString
