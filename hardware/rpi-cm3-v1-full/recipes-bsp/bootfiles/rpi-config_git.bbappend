SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy_append() {

    # Enable raspberry pi 7" display
    if [ ${DISPLAY_TYPE} == "rpi7"]; then
        echo "ignore_lcd=0" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "dtoverlay=rpi-backlight" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "dtoverlay=rpi-ft5406" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    # Enable audio 
    sed -i '/#dtparam=audio=off/ c\dtparam=audio=on' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enable onboard temp sensor
    echo "dtoverlay=i2c-sensor,addr=0x4f,lm75" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enable onboard RTC
    echo "dtoverlay=i2c-rtc,ds1307" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # HDMI display rotation
    # 0 = none, 1 = 90cw, 2 = 180cw, 3 = 270cw, 0x10000 = hflip, 0x20000 = vflip
    if [ -n "${DISPLAY_ROTATE}" ]; then
        sed -i '/#display_rotate=/ c\display_rotate=${DISPLAY_ROTATE}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    # Setup ethernet 
    echo "dtoverlay=enc28j60,int_pin=34" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Setup shutdown and power off signal 
    echo "dtoverlay=gpio-shutdown,gpio_pin=5,active_low=1,gpio_pull=off" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "dtoverlay=gpio-poweroff,gpiopin=35,active_low=1" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Setup CMA
    sed -i '/#cma_lwm=16/ c\cma_lwm=16' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    sed -i '/#cma_hwm=32/ c\cma_hwm=32' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    # Enabled the watchdog timer
    echo "dtparam=watchdog=on" >>${DEPLOYDIR}/bcm2835-bootfiles/config.txt
}
