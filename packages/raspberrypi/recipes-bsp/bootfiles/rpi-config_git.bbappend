SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy_append() {
    # Set kernal image string
    if [ -z "${MENDER_ARTIFACT_NAME}" ]; then
        if [ -n "${KERNEL_IMAGETYPE}" ]; then
            sed -i '/#kernel=/ c\kernel=${KERNEL_IMAGETYPE}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi
    fi

    # Disable rainbow splash screen on boot
    sed -i '/#disable_splash=/ c\disable_splash=1' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
}
