#!/bin/sh

# Load the RTC into the sys tree
#bash -c 'echo -n ds1307 0x68 > tee /sys/class/i2c-adapter/i2c-1/new_device'
echo -n ds1307 0x68 > tee /sys/class/i2c-adapter/i2c-1/new_device

# Set the OS time from the device
hwclock -s
