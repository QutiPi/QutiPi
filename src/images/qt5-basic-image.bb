SUMMARY = "A basic Qt5 qwidgets dev image"
HOMEPAGE = ""
LICENSE = "MIT"

require console-image.bb

inherit populate_sdk_qt5

IMAGE_FEATURES += "dev-pkgs"

RDEPENDS_${PN}_append_linux = "\
    nativesdk-python3-modules \
    nativesdk-python3-misc \
    nativesdk-perl-modules \
    "

RDEPENDS_${PN}_append = "\
    nativesdk-make \
    nativesdk-libgcc \
    nativesdk-libstdc++ \
    "

TOOLCHAIN_HOST_TASK_append = " nativesdk-make nativesdk-libgcc nativesdk-libstdc++"

TOOLCHAIN_HOST_TASK_append_linux = "nativesdk-python3-modules nativesdk-python3-misc nativesdk-perl-modules"


QT_DEV_TOOLS = " \
    qtbase-dev \
    qtbase-mkspecs \
    qtbase-plugins \
    qtbase-tools \
    qtserialport-dev \
    qtserialport-mkspecs \
"

QT_TOOLS = " \
    qtbase \
    qt5-env \
    qtserialport \
"

FONTS = " \
    fontconfig \
    fontconfig-utils \
    ttf-bitstream-vera \
"

TSLIB = " \
    tslib \
    tslib-conf \
    tslib-calibrate \
    tslib-tests \
"

IMAGE_INSTALL += " \
    ${FONTS} \
    ${QT_TOOLS} \
    qcolorcheck \
    ${TSLIB} \
    tspress \
"

export IMAGE_BASENAME = "qt5-basic-image"
