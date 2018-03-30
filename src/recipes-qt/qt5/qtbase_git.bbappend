DEPENDS += "userland"

PACKAGECONFIG += " \
    accessibility \
    cups \
    fontconfig \
    freetype \
    gif \
    glib \
    ico \
    icu \
    libinput \
    linuxfb \
    qml-debug \
    sql-sqlite \
    tslib \
    xkbcommon-evdev \
    eglfs \
    gles2 \
    linuxfb \
    "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-Add-win32-g-oe-mkspec-that-uses-the-OE_-environment.patch \
    "

# make other libgbm providers possible
PACKAGECONFIG[gbm] = "-gbm,-no-gbm,virtual/libgbm"
