#!/bin/bash

# Get the current dir
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Hard set required variables for now
export MACHINE=raspberrypi-cm3
export OETMP=~/Documents/meta-qutipi/build/tmp

# Prep the sd
sudo ${parent_path}/mk2parts.sh sdg

# Ensure nothing is using the sd
sudo umount /dev/sdg1
sudo umount /dev/sdg2

# Flash boot partition
${parent_path}/copy_boot.sh sdg

# Flash root file system partition
${parent_path}/copy_rootfs.sh sdg qt5 qutipi
