FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '\
                   file://psplash-quit.service \
                   file://psplash-start.service \
                   file://psplash-final.service \
                   ', '', d)}"


# Update to latest version of psplash
SRCREV = "5b3c1cc28f5abdc2c33830150b48b278cc4f7bca"

# Remove the loading bar as it does not support systemd
SRC_URI_append = " file://0001-plash-colors.h-color-change.patch \
                   file://0001-psplash-disable-progress-bar-for-systemd.patch \
                 "

SPLASH_IMAGES += "file://psplash-customise-img.h;outsuffix=customise"
ALTERNATIVE_PRIORITY_psplash-customise[psplash] = "110"

# Inherti systemd class
inherit systemd

# Set to name of services files
SYSTEMD_SERVICE_${PN} = "psplash-start.service psplash-quit.service psplash-final.service"

# Ensure start on boot
SYSTEMD_AUTO_ENABLE ?= "enable"

# Install
do_install_append() {
        if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
                install -d ${D}${systemd_unitdir}/system/
                install -m 0644 ${WORKDIR}/psplash-quit.service ${D}${systemd_unitdir}/system
                install -m 0644 ${WORKDIR}/psplash-start.service ${D}${systemd_unitdir}/system
                install -m 0644 ${WORKDIR}/psplash-final.service ${D}${systemd_unitdir}/system
        fi
}
