# Custom Splash with psplash

One option for Qutipi is to use psplash over plymouth. This is a simple slpash screen that can be customised easily.

## Install Libraries

We need access to gdk-pixbuf-csource so lets installs it's package

```bash
sudo apt-get install libgtk2.0-dev
```

## Create Customise Layer

First copy a standard customise layer into your own layer

```bash
cp customise/qutipi customise/crazysplash
```

## Prep Directory

Navigate to your new layer

```bash
cd customise/crazysplash/files
rm psplash-customise-img.h
```

Remove the current header image

```bash
rm files/psplash-customise-img.h
```

## Convert PNG to Header Image

Next we convert your png file to an image header file.

WARNING: Ensure your png files is called "psplash-customise.png"

```bash
./../../../../../tools/psplash/make-image-header.sh psplash-customise.png POKY
```

## Background

If you want to change the background colour then just edit "files/0001-plash-colors.h-color-change.patch" file with hex values of your RGB background.

