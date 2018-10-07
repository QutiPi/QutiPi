SUMMARY = "Setup the etherent interface mac address not required with networkd"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://init \
            file://etherent-setup.sh \
            file://etherent-setup.service \
           "

FILES_${PN}_append = " /data/scripts/etherent-setup.sh"

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
    # Place in persistence location
    install -d ${D}/data/scripts
    install -m 0755 etherent-setup.sh ${D}/data/scripts

    # Symbolic link to script
    install -d ${D}${sysconfdir}/scripts
    # install -m 0744 etherent-setup.sh ${D}${sysconfdir}/scripts
    ln -sf /data/scripts/etherent-setup.sh ${D}${sysconfdir}/scripts

    # Sysv service files
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/etherent-setup

    # Create service for systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/etherent-setup.service ${D}${systemd_unitdir}/system
    fi
    
}

FILES_${PN} = "${sysconfdir}"

