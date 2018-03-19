SUMMARY = "Add firewall to init scripts"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://init \
            file://firewall.rules \
            file://flush-firewall-rules.sh \
            file://firewall-rules.service \
           "

PR = "r0"

S = "${WORKDIR}"

inherit update-rc.d systemd

INITSCRIPT_NAME = "firewall"
INITSCRIPT_PARAMS = "start 60 S ."

# Set to name of services files
SYSTEMD_SERVICE_${PN} = "firewall-rules.service"

# Ensure start on boot
SYSTEMD_AUTO_ENABLE ?= "enable"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/firewall
    install -m 0744 firewall.rules ${D}${sysconfdir}

    install -d ${D}${sysconfdir}/scripts
    install -m 0744 flush-firewall-rules.sh ${D}${sysconfdir}/scripts

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/firewall-rules.service ${D}${systemd_unitdir}/system
    fi
    
}

FILES_${PN} = "${sysconfdir}"

RDEPENDS_${PN} = "iptables"
