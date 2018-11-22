FILESEXTRAPATHS_prepend_rpi := "${THISDIR}/patches:"

SRC_URI_append_rpi = " \
    file://010_Silent-boot.patch \
"
