SUMMARY = "Copies the RPI overlays from RPI firmeware repo to boot folder"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "af994023ab491420598bfd5648b9dcab956f7e11"
SRC_URI = "git://github.com/raspberrypi/firmware.git;protocol=git;branch=stable \
          "


PR = "r0"
S = "${WORKDIR}/git"



inherit deploy


do_deploy() {
    # Ensure dir exists
    install -d ${DEPLOYDIR}/overlays
    
    # Copy the overlays bcm2835-bootfiles
    cp ${S}/boot/overlays/* ${DEPLOYDIR}/overlays
}


addtask deploy before do_package after do_install
#do_image_rpi_sdimg[dirs] = "overlays"
do_deploy[dirs] += "${DEPLOYDIR}/overlays"