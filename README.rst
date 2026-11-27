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

*********************************
Required libraries (dependencies)
*********************************

* `lib_xud <https://www.xmos.com/file/lib_xud>`_
* `lib_logging <https://www.xmos.com/file/lib_logging>`_
* `lib_xassert <https://www.xmos.com/file/lib_xassert>`_

*************************
Related application notes
*************************

* AN00124: USB CDC Class as Virtual Serial Port

*******
Support
*******

This package is supported by XMOS Ltd. Issues can be raised against the software at
`www.xmos.com/support <https://www.xmos.com/support>`_ or using GitHub `issues <https://github.com/xmosnotes/an00131/issues>`_.
