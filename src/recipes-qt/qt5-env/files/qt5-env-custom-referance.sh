#!/bin/sh

export PATH=${PATH}:/usr/bin/qt5

# the other option is linuxfb if just using qt widgets
export QT_QPA_PLATFORM=eglfs

# Hide cursor or not
export QT_QPA_EGLFS_HIDECURSOR=${HIDE_CURSOR}

# Setup a custom LCD screen
export QT_QPA_EGLFS_WIDTH=${EGLFS_WIDTH}
export QT_QPA_EGLFS_HEIGHT=${EGLFS_HEIGHT}
export QT_QPA_EGLFS_PHYSICAL_WIDTH=${EGLFS_PWIDTH}
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=${EGLFS_PHEIGHT}
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=${TOUCHSCREEN_ADDRESS}:rotate=${TOUCHSCREEN_ROTATION}

# Where to store small temporary files
if [ -z "${XDG_RUNTIME_DIR}" ]; then
    export XDG_RUNTIME_DIR=/tmp/user/${UID}

    if [ ! -d ${XDG_RUNTIME_DIR} ]; then
        mkdir -p ${XDG_RUNTIME_DIR}
    fi
fi
