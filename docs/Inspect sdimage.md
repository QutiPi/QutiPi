# Inspecting sdimg

Once the sd card image has been created, you can flash it straight away to an sd card; or first inspect the image.

Run the following to see the partitions

```bash
fdisk -u -l qt5-image-raspberrypi-cm3.sdimg
```

Create a folder where you would like the mount one of the partitions

```bash
mkdir part1
```

Now mount the partitions to the new folder

| NOTE: {VALUE} = Start * Units 
|       For example: {VALUE} = 24576 * 512 = 12582912

```bash
sudo mount -o loop,offset={VALUE} qt5-image-raspberrypi-cm3.sdimg1 part1
```

Inspect and then finally unmount and delete the folder

```bash
sudo umount part1
rm -r part1
```
