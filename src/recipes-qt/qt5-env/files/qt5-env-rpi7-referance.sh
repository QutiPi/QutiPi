#!/bin/sh

export PATH=${PATH}:/usr/bin/qt5

# the other option is linuxfb if just using qt widgets
export QT_QPA_PLATFORM=eglfs

# Setup RPI 7" LCD
export QT_QPA_EGLFS_PHYSICAL_WIDTH=${EGLFS_PWIDTH}
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=${EGLFS_PHEIGHT}

# Where to store small temporary files
if [ -z "${XDG_RUNTIME_DIR}" ]; then
    export XDG_RUNTIME_DIR=/tmp/user/${UID}

    if [ ! -d ${XDG_RUNTIME_DIR} ]; then
        mkdir -p ${XDG_RUNTIME_DIR}
    fi
fi
