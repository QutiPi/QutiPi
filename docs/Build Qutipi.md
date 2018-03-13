# Compiling the QutiPi Distribution

Follow the below to compile QutiPi from scratch. Currently this is a slightly annoying proccess which will be simplified soon.

## QutiPi Source

Pull the source from git

```bash
cd ~/Documents
git clone https://github.com/QutiPi/meta-qutipi.git
```

## Enter meta-qutipi build dir

Navigate to meta qutipi build director:

```bash
cd ~/Documents/meta-qutipi/build
``` 

## Setup Yocto Enviroment

Create the build config dir and setup the template configuration directory

```bash
mkdir -p ~/Documents/meta-qutipi/build/conf
cp ~/Documents/meta-qutipi/src/conf/templateconf.cfg ~/Documents/meta-qutipi/build/conf/templateconf.cfg
```

Next we need to run a Yocto script to setup some enviroment settings

```bash
source ../vendor/poky-rocko/oe-init-build-env ~/Documents/meta-qutipi/build
```

## Edit local.conf

Next if you look in the build directoru you will see a local.conf file. I recommend you only change the "MANUFACTURER" && "MACHINE" && "Default user account" to select your target architecture. The reset should be set so the project is built in a self contained directory. However if you want to tune performance or required storage space to builds feel free to have a play.

There may be variable in here which you want to edit for example:

  * MANUFACTURER: This is the manufacturer of the hardware to help group taregt architectures (eg raspberrypi)
  * MACHINE: The hardware identification which determins the target architecture (eg raspberrypi-cm3)
  * EXTRA_USERS_PARAMS: PLEASE CHANGE the default user account password by replacing the word "qutipi" with your desired password
  * DL_DIR: The central download directory used by the build process to store downloads
  * SSTATE_DIR: The directory for the shared state cache
  * TMPDIR: For all build output and intermediate files (other than the shared state cache)

## Build Qutipi

We are now going to build Qutipi using bitbake by running the following

```bash
bitbake qt5-image
```








