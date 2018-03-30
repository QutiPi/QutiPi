#!/bin/sh

export PATH=${PATH}:/usr/bin/qt5

# the other option is linuxfb if just using qt widgets
export QT_QPA_PLATFORM=eglfs

# Hide cursor or not
export QT_QPA_EGLFS_HIDECURSOR=1

# Where to store small temporary files
if [ -z "" ]; then
    export XDG_RUNTIME_DIR=/tmp/user/

    if [ ! -d  ]; then
        mkdir -p 
    fi
fi
