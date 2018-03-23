SUMMARY = "Default app for loading at boot"
HOMEPAGE = ""
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "qtdeclarative qtquickcontrols2 qtserialbus qtcharts"

PR = "r1"

SRCREV = "1e4146ac7dff12e149c29e46ae454ef9738a242e"
SRC_URI = "gitsm://github.com/MU-Electronics/vacuum_reservoir_controller.git"

S = "${WORKDIR}/git"

require recipes-qt/qt5/qt5.inc


do_install() {
    install -d ${D}/home/root/qutipi

    install -m 0755 ${B}/src/src ${D}/home/root/qutipi
    #cp -R ${B} ${D}/home/root/qutipi
    #cp -R --no-dereference --preserve=mode,links ${B} ${D}/home/root/qutipi
    #install -m 0755 ${B}/vendor/qutipi-cpp
}

FILES_${PN} = "/home/root/*"

RDEPENDS_${PN} = "qtdeclarative-qmlplugins qtgraphicaleffects-qmlplugins"

