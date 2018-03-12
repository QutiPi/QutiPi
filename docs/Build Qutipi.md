# Compiling the QutiPi Distribution

Follow the below to compile QutiPi from scratch. Currently this is a slightly annoying proccess which will be simplified soon.

## QutiPi Source

Pull the source from git

```bash
cd ~/Documents
git clone https://github.com/QutiPi/meta-qutipi.git
```

## Enter build dir

Navigate to build director instead meta-qutipi, for example

```bash
cd ~/Documents/meta-qutipi/build
``` 

## Setup Yocto Enviroment

Create the build config dir

```bash
mkdir -p ~/Documents/meta-qutipi/build/conf
```

Next we need to run a Yocto script to setup some enviroment settings

```bash
source ../vendor/poky-rocko/oe-init-build-env ~/Documents/meta-qutipi/build
```

## Copy Config Files

Next we want to copy some configuration files 









