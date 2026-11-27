:orphan:

################################################
AN00131: USB CDC-ECM Class for Ethernet over USB
################################################

:vendor: XMOS
:version: 3.1.0
:scope: Example
:description: An example that runs Ethernet over USB
:category: General purpose
:keywords: USB, Ethernet
:hardware: XK-EVK-XU316

*******
Summary
*******

This app note shows how to implement the *CDC-ECM* class on USB, which
supports emulation of ethernet interfaces over USB. In this example
document we show how to run a web-server over USB on an `XCORE` device.
The web page served by the device controls the board LEDs and shows the
board push-button state and network packet statistics.

********
Features
********

* USB Communications Device Class (CDC)
* Ethernet Control Model (ECM)
* Web page control of board LEDs and display of push-button state

************
Known issues
************

* None

****************
Development repo
****************

* `an00131 <https://www.github.com/xmosnotes/an00131>`_ (https://www.github.com/xmosnotes/an00131)

**************
Required tools
**************

* XMOS XTC Tools: 15.3.1

************************
Host system requirements
************************

macOS and Linux include a USB CDC-ECM class driver, so no host software needs to be
installed. Windows does not include a CDC-ECM class driver; a third party driver is required
for the device to appear as a network interface. The demo is viewed in a web browser. Name
resolution requires mDNS support on the host; use the device IP address (169.254.85.85) if
``xmos-cdc.local`` is unavailable.

*********************************
Required libraries (dependencies)
*********************************

* `lib_xud <https://www.xmos.com/libraries/lib_xud>`_ (https://www.xmos.com/libraries/lib_xud)
* `lib_logging <https://www.xmos.com/libraries/lib_logging>`_ (https://www.xmos.com/libraries/lib_logging)
* `lib_xassert <https://www.xmos.com/libraries/lib_xassert>`_ (https://www.xmos.com/libraries/lib_xassert)

*************************
Related application notes
*************************

* `AN00124 - USB CDC Class as Virtual Serial Port <https://www.xmos.com/application-notes/an00124>`_

*******
Support
*******

This package is supported by XMOS Ltd. Issues can be raised against the software at
`www.xmos.com/support <https://www.xmos.com/support>`_ or using GitHub `issues <https://github.com/xmosnotes/an00131/issues>`_.
