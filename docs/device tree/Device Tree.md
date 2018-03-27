# Device Tree

Currently this project only supports the CM3 from Raspberry pi whoms kernel supports a device tree structure for describing hardware. 

Other device kernels also implement this type of method of describing hardware which is pretty standard across ARM and PowerPC. However this guide will be aimed at the Raspberry Pi kernel but the general knowledge applies to all.

## Overview

A device tree is used to describe hardware in a system. As the name suggests the syntax follows a tree like structure, where each node describes a particular device's characteristics. Nodes are structured in a parent child relationship.

Generally a node is only created for hardware that can not automatically be discovered by the device's program. Device tree nodes are also often used to set peripherals into default states suitable for the system being designed. The aim is to produce a product where every is not just "on" by default but only what is required.

Device trees should also be OS neutral. Their job is not to control the hardware but the supply the infomation that a drive could use to then drive the hardware. Think of it as a menu of devices and options you can select.

## Creating & Editing

Device tree files are compiled using a device tree compiler, to install the compiler on Ubuntu at least, run:

```shell
sudo apt-get install device-tree-compiler
```


Run the following to decompile a device tree blob

```shell
dtc -I dtb -O dts -o rpi-ft5408.dts rpi-ft5406.dtbo
```

Once changes have been made you can then recompile it

```shell
dtc -O dtb -I dts -o rpi-ft5408.dts rpi-ft5406.dtbo
```

  > NOTE: The extension "dtbo" applies to device tree overlays but the above applies to dt-blob.bin files as well

We can inspect the compiled dtb by running the below

```shell
fdtdump rpi-ft5406.dtbo
```

## Device Tree Blob (Semi-Pi Related)

A device tree blob is used only once at boot time to configure the binary blob. This is used by the VideoCore / GPU and is not used by the Linux Kernel to my knowledge. One binary blob can be used to configure all versions of the Raspberry Pi however i discourage that in meta-qutipi as the OS is built per device type + hardware.

Below will explain the basic tree structure of the dt-blob:

  * Videocore: 
    This is the first parent of the tree to define that all children are relevant to the videocore only
    * pins_{type}: 
      This child allows different versions of pi's hardware to be grouped ie pins_cm3, pins_3b2 etc
      * pin_config:
        This child is used to define the default states / configurations for pins
          * pin@p{number}
            This allows one to define a node directly related to a specific pin. For example pin_p20 would be GPIO20.
            * polarity: active_high, active_low
            * termination: pull_up, pull_down, no_pulling
            * startup_state: active, inactive
            * function: input, output, sdcard, i2c0, i2c1, spi, spi1, spi2, smi, dpi, pcm, pwm, uart0, uart1, gp_clk, emmc, arm_jtag
            * drive_strength_ma: drive strength for the pin, 8 or 16
      * pin_defines:
        This node is used to configure the correct pins to use for the Videocore's different functionality. For example you could reconfigure the HDMI or camera ports.


Please [read](https://www.raspberrypi.org/documentation/configuration/pin-configuration.md) for an in depth guide of the dt-blob's functionality for the Pi.


### Extending The Base Device Tree

You can extend the base device tree by using dt-overlays which are described below. To add additional configuration through the used of overlays you will need to edit config.txt found in the "BOOT" partition of the QutiPi.

For example, lets enabled SPI2 with 3 chip enabled pins and set CE0 to pin 42. Open /boot/config.txt and add to the bottom:

```shell
dtoverlay=spi2-3cs,cs0_pin=42
```

Thats it! SPI2 is now enabled with cs 0 set to pin 42. All the other pins have default options so they don't need to setting. 

You can view all the available dt-overlays and their [documentation](https://github.com/raspberrypi/linux/tree/rpi-4.9.y-stable/arch/arm/boot/dts/overlays).

Note the alternative syntax of:
```shell
dtoverlay=spi2-3cs:cs0_pin=42,cs1_pin=38
```

### Setting Device Tree Parameter 

As above saw how we can extend the base device tree with overlays to add additional configurations which can then be access by drivers to give us extra functionality at OS & application level. We also saw that we can pass parameters to the overlays file.

We can also assign scoped variables to the device tree by using dtparam. For example, lets turn on SPI; as before open /boot/config.txt and add to the bottom

```shell
dtparam=spi=on
```

Now this is not really required as if we load the overlay SPI2 for example, it will automatically enable the SPI interface. However there are many other dt-parameters that can be [set](https://github.com/raspberrypi/linux/tree/rpi-4.9.y-stable/arch/arm/boot/dts/overlays).

Or we could define an overlay with parameters on separate lines, for example:

```shell
dtoverlay=spi2-3cs
dtparam=cs0_pin=42
```

We can do this because overlay parameters are only in scope until the next overlay is loaed

### Device Tree Overlays (Semi-Pi Related, dtbo)

If your a modern developer using OOP principles when you'll probably cringe at the thought of one file configuring all the internal AND external peripherals for the device. The file would be very long and hard to understand at first, second... glance. For this reason device tree overlays exist, please use them!

When compiled dt-overlays have an extension of dtb**o** and then un-compiled use the standard dts file extension.

Abstracting out different responsibility can been seen as the function of dt-overlays. For example, if you want to set pins 40-45 to be SPI2 with 3 chip selects then lets create a file called SPI2-3cs.dtbo. Oh, wait... Raspberry Pi have already created this [file](https://github.com/raspberrypi/firmware/blob/master/boot/overlays/spi2-2cs.dtbo) for us, see [dts](https://github.com/raspberrypi/linux/blob/rpi-4.4.y/arch/arm/boot/dts/overlays/spi2-2cs-overlay.dts) version.

Hence what we can now derive is that a base device tree is supplied (dt-blob) and then we can append partial device tree overlays. This allows us to easily create different device trees for different situations without having to create a new base device tree for every project.

Overlays are contain the following:

  * compilable: 
    This identifies the overlay as applying to a particular device, for example "brcm,bcm2708" which is the base arch for the BCM2835
  * fragment@{index}
    There can be multiple fragments index sequentially starting from 0.
      * target: this selects which node the overlay should be appended to
      * \_\_overlay\_\_: this is the actual content that will be appended to the selected node
  * \_\_overrides\_\_:  this option node allows your dt overlay to take parameters. For example, if your overlay to be truly re-usable you cant define what pin is interrupt etc. For that you should ask the person using your overlay, what pin should i use for the interrupt?

There are additional nodes for overlays which are [documented](https://www.raspberrypi.org/documentation/configuration/device-tree.md), however the above are the most popular.

When compiling dt overlays the command is the same as in the first section of this guide. However you may need to append "-@" which allows unresolved dependences. For example,

```shell
dtc -@ -O dtb -I dts -o rpi-ft5408.dts rpi-ft5406.dtbo
```


### Device Tree Include (Semi-Pi Related, dtbi) 

With the power of dt overlays we can create really nice abstraction and re-usable code. However we can go even futher by using include files. These files are as their name suggest, they can be include in many files. 

Therefore if you have a section of script which you require in multiple dt-overlays then use a dt-include files instead of copying and pasting into multiple files.

Be careful however as this can get out of hand!

## Debugging

It can often to quite hard to figure out events before boot, the loader will skip small errors such as missing overlays, bad parameters etc, however errors such as corrupt DTB or failed merges will result in the loader reverting back to a none-DT boot. Check the warning errors from the loader by running the following:

```shell
sudo vcdbg log msg
```

You can increase the amount of logging by adding the following to config.txt
```bash
dtdebug=1
```

To view the DT tree of the current booted situation run the following:
```shell
dtc -I fs /proc/device-tree
```


