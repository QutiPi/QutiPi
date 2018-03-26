#!/bin/bash

# Get the current dir
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Hard set required variables for now
export MACHINE=raspberrypi-cm3
export OETMP=~/Documents/meta-qutipi/build/tmp

# Prep the sd
sudo ${parent_path}/mk2parts.sh $1

# Ensure nothing is using the sd
sudo umount /dev/$11
sudo umount /dev/$12

# Flash boot partition
${parent_path}/copy_boot.sh $1

# Flash root file system partition
${parent_path}/copy_rootfs.sh $1 qt5 qutipi
