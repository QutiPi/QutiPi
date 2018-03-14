# Flashing Qutipi Image

After the build has been completed by Bitbake the next stage is to copy the binaries onto an SD card.

This project contains some addtional helper scripts initally taken from meta-rpi; which help in formatting and flashing the image onto the SD card.

## Find your SD card

First plug the SD card into your computer and then run the following command:

```bash
lsblk
```

This will output a long list of drives attached to your computer. Find the drive which is your SD card and note the name, for example **sdf**.

TIP: Run the command before the SD card is pluged into your PC and after. Compare the two ouputs to find the SD card (also check the size).

WARNING: Selecting the wrong drive and following the below will wipe all data from that drive INCLUDING your computer your using. 

## Navigate

In your terminal navigate to the meta-qutipi directory, for example:

```bash
cd ~/Documents/meta-qutipi
```

## Partition SD Card

Step two is to create two partitions on the SD card. This first parition is for the bootloader and the second for the actual OS which is loaded by the GPU on boot.

Run the following command, **Replacing sdf with your SD card name**:

```bash
sudo ./scripts/mk2parts.sh sdf
```

Then unmount the SD card paritions

```bash
sudo umount /dev/sdf1
sudo umount /dev/sdf2
```

## Creating Mounting Point

To enable us to eventually copy the the image to the SD card using the scripts we need to create a mounting point.

Run the following command:

```bash
sudo mkdir /media/card
```

## Copy Boot Image to SD

This script automats the proccess of copying all the required files to the SD card, for example:

  * GPU Firmware
  * Linux Kernal
  * dtbs
  * overlays
  * config.txt
  * cmdline.txt

Before we run the script first we need to setup a few env variables for the script. I'll demo setting the paths using the defaults and then we'll copy the boot partition. Eventually i plan to full automate this process by saving setting in an xml file on baking and loading using copying.

### Set TMPDIR path

Tell the script where the TMPDIR path is located on your computer.

``` bash
export OETMP=~/Documents/meta-qutipi/build/tmp
```

### Set Machine

The script also needs to know what machine the image was compiled for, for example:

```bash
export MACHINE=raspberrypi-cm3
```

### Copy Boot Partition

Now we copy the boot image to the boot partition. This should only take a few moments and once finished you can customise the config.txt and cmdline.txt files if you wish. Remember you can use the raspberrypi docunmetation as QutiPi uses the RaspberyPi Kernal.

```bash
./scripts/copy_boot.sh sdg
```

## Copy Root Partition

Finally we can now copy the root file system to the root partition, yey. This script needs the "OETMP" and "MACHINE" variables to function but if you have already set them as per above and are still using the same terminal window then your ready to go.

The script accept three commands:

  * SD card location, for example: **sdf**
  * Image type baked, for example: qt5
  * Machine name, for example: qutipi

Run the following command:

```bash
./scripts/copy_rootfs.sh sdb qt5 qutipi
```

