SUMMARY = "Setup the etherent interface"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://init \
            file://etherent-setup.sh \
            file://etherent-setup.service \
           "

PR = "r0"

S = "${WORKDIR}"

inherit update-rc.d systemd

# Init name
INITSCRIPT_NAME = "etherent-setup"

# Set to name of services files
SYSTEMD_SERVICE_${PN} = "etherent-setup.service"

# Ensure start on boot
SYSTEMD_AUTO_ENABLE ?= "enable"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/etherent-setup

    install -d ${D}${sysconfdir}/scripts
    install -m 0744 etherent-setup.sh ${D}${sysconfdir}/scripts

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/etherent-setup.service ${D}${systemd_unitdir}/system
    fi
    
}

FILES_${PN} = "${sysconfdir}"

