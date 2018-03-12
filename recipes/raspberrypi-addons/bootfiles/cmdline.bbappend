

do_deploy_append() {
    # Disable raspberry pi logo on boot
    sed -i '/rootwait/ c\logo.nologo rootwait' ${DEPLOYDIR}/bcm2835-bootfiles/cmdline.txt
}
