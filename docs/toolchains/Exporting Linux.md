# Exporting Linux Toolchain

This can be done automatically using QutiPi and bitbake.

## Building the SDK

Open build/conf/local.conf and uncomment and comment out the below

```shell
SDKMACHINE = "x86_64"

# SDK target architecture windows 
#SDKMACHINE = "x86_64-mingw32"
#OE_QMAKE_PLATFORM_NATIVE_mingw32 = "win32-g++-oe"
#OE_QMAKE_PLATFORM_mingw32 = "win32-g++-oe"
#QT_MODULE_BRANCH_PARAM = "nobranch=1"
#PACKAGE_EXCLUDE_COMPLEMENTARY ?= "qtquickcompiler"


#SDKMACHINE = "i386-darwin"
```

Next open a terminal in the build directory and setup the environment 

```shell
source ../vendor/poky-rocko/oe-init-build-env ~/Documents/meta-qutipi/build
```

Now build the image and create the SDK

```shell
bitbake qt5-image -c populate_sdk
```

The resulting toolchain is located in build/tmp/depoly/sdk/qutipi-x86_64-qt5-image-raspberrypi-cm3.sh

## Install SDK

This SDK can be installed on any linux OS. To install it open a terminal and run the shell script.

```shell
./qutipi-x86_64-qt5-image-raspberrypi-cm3.sh
```

The script will ask you where you want it installed. Hit Enter then Y to use the default location shown in the terminal.

Next you need to open sysroots/x86_64-pokysdk-linux/usr/bin/qt5/qt.conf and append the installation directory to the following variables. I'll extract my tool chain directly in /opt/qutipi/2.4.2/
```shell
HostPrefix = /opt/qutipi/2.4.2/sysroots/x86_64-pokysdk-linux
HostData = /opt/qutipi/2.4.2/sysroots/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/usr/lib/qt5
HostBinaries = /opt/qutipi/2.4.2/sysroots/x86_64-pokysdk-linux/usr/bin/qt5
HostLibraries = /opt/qutipi/2.4.2/sysroots/x86_64-pokysdk-linux/usr/lib
Sysroot = /opt/qutipi/2.4.2/sysroots/cortexa7hf-neon-vfpv4-poky-linux-gnueabi
```

When running compilations via the terminal be sure to run environment-setup-cortexa7hf-neon-vfpv4-poky-linux-gnueabi file first to setup environment variables.

Guide to follow on setting up Qt Creator.

