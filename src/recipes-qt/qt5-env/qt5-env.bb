SUMMARY = "Add Qt5 bin dir to PATH"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://qt5-env.sh"

PR = "r1"

S = "${WORKDIR}"

##
# Create config file for Qt enviroment vairables to run on boot
##
python do_create_qtenv(){
    import re

    # Get path to current recipe
    rootBbclassAppend = d.getVar('THISDIR')

    # Select the referance interface depending on the type required
    referance = rootBbclassAppend + "/files/qt5-env-"+d.getVar('DISPLAY_TYPE')+"-referance.sh"

    # Open the selected interface file and get the conent
    with open(referance, 'r') as instream:
        content = instream.read()

    # Replace placeholders in the content with local variables
    content=re.sub("\${(.*?)}", (lambda m: d.getVar(m.group(1)) if m.group(1) != 'PATH' else '${PATH}'), content)

    # Create the new interface file
    with open(rootBbclassAppend + "/files/qt5-env.sh", 'w') as outstream:
        outstream.write(content)
}
# Run function before build to generate the env shell file
addtask do_create_qtenv before do_build

do_install() {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0755 qt5-env.sh ${D}${sysconfdir}/profile.d
}

FILES_${PN} = "${sysconfdir}"

