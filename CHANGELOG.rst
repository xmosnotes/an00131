an00131 Changelog
=================

UNRELEASED
----------

  * ADDED: Web page controls for the board LEDs and display of push-button
    state
  * FIXED: xmos-cdc.local not resolving on hosts that ask for record types
    other than A, set the mDNS unicast-response bit or use name compression.
    The device now also announces its name after DHCP and ARP
  * FIXED: Code excerpts in the application note that showed the wrong source
    lines
  * FIXED: Application note stated that the notification endpoint is not used
  * FIXED: Mismatched HTML tags in the web page
  * FIXED: Typos in the application note and README

  * Changes to dependencies:

    - lib_logging: 3.3.1 -> 3.5.0

    - lib_xassert: 4.3.1 -> 5.1.0

    - lib_xud: 3.0.0 -> 4.0.1

3.1.0
-----

  * Changes to dependencies:

      - lib_xud: 2.4.0 -> 3.0.0

3.0.0
-----

  * Moved from lib_xud/examples to xmosnotes

2.0.0
-----

  * Initial version. Released as part of lib_xud prior to version 2.4.0
