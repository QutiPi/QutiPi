SUMMARY = "Setup the base dt blob to include display and camera ports"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://dt-blob.bin \
           "
PR = "r0"
S = "${WORKDIR}"

inherit deploy

do_compile_dt_blob() {
    ${THISDIR}/files/compile.sh ${THISDIR}/files
}
addtask do_compile_dt_blob before do_build


do_deploy() {
    # Ensure dir exists
    install -d ${THISDIR}/bcm2835-bootfiles
    
    # Copy the dt-blob.bin file
    cp ${THISDIR}/files/dt-blob.bin ${DEPLOYDIR}/bcm2835-bootfiles/
}

addtask deploy before do_package after do_install
do_deploy[dirs] += "${DEPLOYDIR}/bcm2835-bootfiles"