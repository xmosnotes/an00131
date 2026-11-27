:orphan:

################################################
AN00131: USB CDC-ECM Class for Ethernet over USB
################################################

:vendor: XMOS
:version: 3.1.0
:scope: Example
:description: An example that runs Ethernet over USB
:category: General Purpose
:keywords: USB, Ethernet, Webserver
:hardware: XK-EVK-XU316

********
Overview
********

This app note shows how to implement the *CDC-ECM* class on USB, which
supports emulation of ethernet interfaces over USB. In this example
document we show how to run a web-server over USB on an `xcore` device.
The web page served by the device controls the board LEDs and shows the
board push-button state and network packet statistics.

************
Key features
************

* USB Communications Device Class (CDC)
* Ethernet Control Model (ECM)
* Web page control of board LEDs and display of push-button state

************
Known issues
************

* None

**************
Required tools
**************

* XMOS XTC Tools: 15.3.1

*********************************
Required libraries (dependencies)
*********************************

* `lib_xud <https://www.xmos.com/file/lib_xud>`_

*************
Related notes
*************

* AN00124: USB CDC Class as Virtual Serial Port

*******
Support
*******

This package is supported by XMOS Ltd. Issues can be raised against the software at: http://www.xmos.com/support

