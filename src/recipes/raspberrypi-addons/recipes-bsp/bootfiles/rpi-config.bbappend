SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy_append() {
    # Disable rainbow splash screen on boot
    sed -i '/#disable_splash=/ c\disable_splash=1' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enable audio 
    sed -i '/#dtparam=audio=off/ c\dtparam=audio=on' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enable onboard temp sensor
    echo "dtoverlay=i2c-sensor,addr=0x4f,lm75" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enable onboard RTC
    echo "dtoverlay=i2c-rtc,d1307" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # HDMI display rotation
    # 0 = none, 1 = 90cw, 2 = 180cw, 3 = 270cw, 0x10000 = hflip, 0x20000 = vflip
    if [ -n "${DISPLAY_ROTATE}" ]; then
        sed -i '/#display_rotate=/ c\display_rotate=${DISPLAY_ROTATE}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi
}