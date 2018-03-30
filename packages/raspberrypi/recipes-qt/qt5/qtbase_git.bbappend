
SRC_URI += " \
    file://oe-device-extra.pri \
    "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_configure_prepend() {
    install -m 0644 ${WORKDIR}/oe-device-extra.pri ${S}/mkspecs
}

