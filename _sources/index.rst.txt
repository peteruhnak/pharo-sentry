.. Pharo Sentry documentation master file, created by
   sphinx-quickstart on Mon Mar 12 11:06:09 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Pharo Sentry's documentation!
========================================

|travis| |coveralls|

*pharo-sentry* is an unofficial `Pharo <https://pharo.org/>`_ SDK for `Sentry <https://sentry.io/welcome/>`_ error tracking platform.

.. warning::

  This SDK is still under development and not all Sentry's API is supported yet.

.. warning::

  The API of this library is still subject to change.

Getting Started
---------------

The best way to familiarize yourself with *pharo-sentry* is to go through the example scenarios.

.. toctree::
    :maxdepth: 2

    getting_started

Advanced Usage
--------------

The utilize the full power of Sentry, you may need to dive into advanced topics.

.. toctree::
    :maxdepth: 2

    advanced_usage

Beacon
------

Sentry should be used as a backend for other logging/tracking libraries.
*pharo-sentry* provides a custom logger for Beacon.

.. toctree::
    :maxdepth: 2

    beacon

Settings
--------

Several options of *pharo-sentry* can be configured in global settings.

.. toctree::
    :maxdepth: 2

    settings


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

.. |travis| image:: https://travis-ci.org/peteruhnak/pharo-sentry.svg?branch=master
    :target: https://travis-ci.org/peteruhnak/pharo-sentry
.. |coveralls| image:: https://coveralls.io/repos/github/peteruhnak/pharo-sentry/badge.svg?branch=master
    :target: https://coveralls.io/github/peteruhnak/pharo-sentry?branch=master
