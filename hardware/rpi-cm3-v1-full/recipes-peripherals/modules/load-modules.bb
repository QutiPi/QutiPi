SUMMARY = "Load spi and i2c by default"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://raspberrypi.conf \
           "

PR = "r0"

S = "${WORKDIR}"

FILES_${PN} = "${sysconfdir}"

do_install() {
    install -d ${D}${sysconfdir}/modules-load.d/
    install -m 0755 raspberrypi.conf ${D}${sysconfdir}/modules-load.d/
}

