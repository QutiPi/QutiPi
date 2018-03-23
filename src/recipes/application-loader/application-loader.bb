SUMMARY = "Controls the default application that loads a boot"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://init \
            file://application-loader.sh \
            file://application-loader.service \
           "

PR = "r0"

S = "${WORKDIR}"

inherit update-rc.d systemd

# Init name
INITSCRIPT_NAME = "application-loader"

# Set to name of services files
SYSTEMD_SERVICE_${PN} = "application-loader.service"

# Ensure start on boot
SYSTEMD_AUTO_ENABLE ?= "enable"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/application-loader

    install -d ${D}${sysconfdir}/scripts
    install -m 0744 application-loader.sh ${D}${sysconfdir}/scripts

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/application-loader.service ${D}${systemd_unitdir}/system
    fi
    
}

FILES_${PN} = "${sysconfdir}"

