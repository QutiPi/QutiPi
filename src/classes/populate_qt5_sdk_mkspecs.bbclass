

inherit siteinfo


# Define file locations
SDK_MKSPEC_DIR = "${SDK_OUTPUT}${SDKTARGETSYSROOT}${libdir}/${QT_DIR_NAME}/mkspecs"
NATIVE_SDK_MKSPEC_DIR = "${SDK_OUTPUT}${SDKPATHNATIVE}${libdir}/${QT_DIR_NAME}/mkspecs"

# Define target compiling for
SDK_MKSPEC = "devices/linux-oe-generic-g++"

# Path to file with device info in 
SDK_DEVICE_PRI = "${SDK_MKSPEC_DIR}/qdevice.pri"
SDK_DYNAMIC_FLAGS = "-O. -pipe -g"


##
# Setup Qt makespec / config files
##
create_sdk_files_append () {
    # Create makespec file configured for target device
    install -d ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}
    cat > ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}/qmake.conf <<EOF
include(../common/linux_device_pre.conf)
exists(../../oe-device-extra.pri):include(../../oe-device-extra.pri)
include(../common/linux_device_post.conf)
load(qt_config)
EOF

    cat > ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}/qplatformdefs.h <<EOF
#include "../../linux-g++/qplatformdefs.h"
EOF

    # Set info in the qdevice.pri file to be used by the device makespec
    static_cflags="${TARGET_CFLAGS}"
    static_cxxflags="${TARGET_CXXFLAGS}"
    for i in ${SDK_DYNAMIC_FLAGS}; do
        static_cflags=$(echo $static_cflags | sed -e "s/$i //")
        static_cxxflags=$(echo $static_cxxflags | sed -e "s/$i //")
    done
    echo "MACHINE = ${MACHINE}" > ${SDK_DEVICE_PRI}
    echo "CROSS_COMPILE = \$\$[QT_HOST_PREFIX]${bindir_nativesdk}/${TARGET_SYS}/${TARGET_PREFIX}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_CFLAGS *= ${TARGET_CC_ARCH} ${static_cflags}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_CXXFLAGS *= ${TARGET_CC_ARCH} ${static_cxxflags}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_LFLAGS *= ${TARGET_CC_ARCH} ${TARGET_LDFLAGS}" >> ${SDK_DEVICE_PRI}

    # Setup qt.conf to point at the device makespec by default
    qtconf=${SDK_OUTPUT}/${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS}/qt.conf
    echo 'HostSpec = linux-g++' >> $qtconf
    echo 'TargetSpec = devices/linux-oe-generic-g++' >> $qtconf

    # Link /etc/resolv.conf is broken in the toolchain sysroot, remove it
    rm -f ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/resolv.conf
}

##
# Replace links in qt.conf for default suggested windows location
##
create_sdk_files_append_mingw32 () {
    # Where is the qt conf file
    qtconf=${SDK_OUTPUT}/${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS}/qt.conf

    # Where is the new path of SDK
    newPath = "C:/qutipi/${HARDWARE}/${SDK_VERSION}"

    # Replace old path for new path
    sed -i 's/\/opt\/qutipi\/2.4.2/$newPath/g' ${qtconf}
}

##
# Replace links in qt.conf for default suggested linux location
##
create_sdk_files_append_linux () {
    # Where is the qt conf file
    qtconf=${SDK_OUTPUT}/${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS}/qt.conf

    # Where is the new path of SDK
    newPath = "/opt/qutipi/${HARDWARE}/${SDK_VERSION}"

    # Replace old path for new path
    sed -i 's/\/opt\/qutipi\/2.4.2/$newPath/g' ${qtconf}
}
