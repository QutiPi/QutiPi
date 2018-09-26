# Flash sdimg file

Once you have built the os you will find an sdimg file in

| build/tmp/deploy/images/{machine}/{image}-{machine}.sdimg

for example

| build/tmp/deploy/images/raspberrypi-cm3/qt5-image-raspberrypi-cm3.sdimg

This file contains everything requires to flash an sd card with paritions configured automatically.

## Flashing

To flash the sd card run the following, **WHERE** sdb is the location of the sd card.

```bash
sudo dd if=/home/electronics/Documents/meta-qutipi/build/tmp/deploy/images/raspberrypi-cm3/qt5-image-raspberrypi-cm3.sdimg of=/dev/sdb bs=1M && sudo sync
```

