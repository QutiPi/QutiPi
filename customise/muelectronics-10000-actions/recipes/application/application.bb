SUMMARY = "Default app for loading at boot"
HOMEPAGE = ""
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "qtdeclarative qtquickcontrols2 qtserialbus qtcharts qtsvg"

PR = "r1"

# 1e4146ac7dff12e149c29e46ae454ef9738a242e
SRCREV = "c8f960662f47adde230558362f2ae076a036ba4b"
SRC_URI = "gitsm://github.com/MU-Electronics/vacuum_reservoir_controller.git"

S = "${WORKDIR}/git"

require recipes-qt/qt5/qt5.inc


do_install() {
	# Ensure qutipi folder is created
    install -d ${D}/home/root/qutipi

    # Install the main application
    install -m 0755 ${B}/src/src ${D}/home/root/qutipi

    # Install fluid
    install -d ${D}/home/root/qutipi/Fluid
    cp -R ${B}/vendor/fluid/qml/Fluid/* ${D}/home/root/qutipi/Fluid
}

FILES_${PN} = "/home/root/*"

RDEPENDS_${PN} = "qtdeclarative-qmlplugins qtgraphicaleffects-qmlplugins"

