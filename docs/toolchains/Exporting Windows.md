# Exporting Windows Toolchain

This can be done automatically using QutiPi and bitbake.

## Building the SDK

Open build/conf/local.conf and uncomment and comment out the below

```shell
#SDKMACHINE = "x86_64"

# SDK target architecture windows 
SDKMACHINE = "x86_64-mingw32"
OE_QMAKE_PLATFORM_NATIVE_mingw32 = "win32-g++-oe"
OE_QMAKE_PLATFORM_mingw32 = "win32-g++-oe"
QT_MODULE_BRANCH_PARAM = "nobranch=1"
PACKAGE_EXCLUDE_COMPLEMENTARY ?= "qtquickcompiler"


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

The resulting toolchain is located in build/tmp/depoly/sdk/qutipi-x86_64-mingw32-qt5-image-raspberrypi-cm3.tar.xz


## Install SDK

This SDK can be installed on any windows version, I've only tested on windows 7 & 8. To install it extract the SDK.

Next you need to open sysroots/x86_64-pokysdk-mingw32/usr/bin/qt5/qt.conf and append the installation directory to the following variables. I'll extract my tool chain directly in C:/qutipi/cm3
```shell
HostPrefix = C:/qutipi/cm3/sysroots/x86_64-pokysdk-linux
HostData = C:/qutipi/cm3/sysroots/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/usr/lib/qt5
HostBinaries = C:/qutipi/cm3/sysroots/x86_64-pokysdk-linux/usr/bin/qt5
HostLibraries = C:/qutipi/cm3/sysroots/x86_64-pokysdk-linux/usr/lib
Sysroot = C:/qutipi/cm3/sysroots/cortexa7hf-neon-vfpv4-poky-linux-gnueabi
```

When running compilations via the terminal be sure to run environment-setup-cortexa7hf-neon-vfpv4-poky-linux-gnueabi.bat file first to setup environment variables.

Guide to follow on setting up Qt Creator.
