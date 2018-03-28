#!/bin/sh -e

cd $1

/usr/bin/dtc -I dts -O dtb -o dt-blob.bin dt-blob.dts
