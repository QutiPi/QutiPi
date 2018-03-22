SUMMARY = "Setup "

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://50-${ETHERNET_TYPE}.network \
           "

PR = "r0"
S = "${WORKDIR}"

##
# Create config file for networkd ethernet interface
##
python do_create_configuration(){
    import re

    # Get path to current recipe
    rootBbclassAppend = d.getVar('THISDIR')

    # Select the referance interface depending on the type required
    referance = rootBbclassAppend + "/files/50-referance-" + d.getVar('ETHERNET_TYPE') + ".network"

    # Open the selected interface file and get the conent
    with open(referance, 'r') as instream:
        content = instream.read()

    # Replace placeholders in the content with local variables
    content=re.sub("\${(.*?)}", (lambda m: d.getVar(m.group(1))), content)

    # Create the new interface file
    with open(rootBbclassAppend + "/files/50-" + d.getVar('ETHERNET_TYPE') + ".network", 'w') as outstream:
        outstream.write(content)
}


# Run function before build to generate the interfaces file
addtask do_create_configuration before do_build

do_install() {
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0755 50-${ETHERNET_TYPE}.network ${D}${sysconfdir}/systemd/network 
}

FILES_${PN} = "${sysconfdir}"

