# QutiPi-Meta

Meta layer used with Yocto to build a custom linux distribution for QutiPi board and Raspberry Pi 3.

The distribution called QutiPi after the project name is designed to be rugged and bare bones without losing crucial features.

The current main features are:

  * Yocto sumo base distribution
  * Systemd (system and service manager)
  * networkd for network adapter configuration and control
  * Firewall with default simple secure rule set
  * Qt 5.10
  * OpenSSH
  * Watchdog for cpu
  * Application loader
  * Psplash customisable bootup screen 
  * Raspberry Pi CM3 support + QutiPi motherboard V1 support
  * RTC and set custom mac
  * Exportable SDK for linux & windows

## Acknowledgements

If your intrested in other examples of distribution using Yocto see the following; they were a great help in the development of QutiPi OS. 

  * Jumpnow Technologies: [meta-rpi](https://github.com/jumpnow/meta-rpi), [tutorial](http://www.jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Yocto.html) 
  * Lirios: [meta-liri](https://github.com/lirios/meta-liri)

## Licensing

Licensed under the GNU Lesser General Public License (LGPL) version 3.

All rights reserved to change at any time.

